package search

import (
	provider "github.com/cs3org/go-cs3apis/cs3/storage/provider/v1beta1"
	"github.com/cs3org/reva/v2/pkg/events"
	"github.com/owncloud/ocis/v2/ocis-pkg/log"
	"github.com/owncloud/ocis/v2/services/search/pkg/config"
)

// HandleEvents listens to the needed events,
// it handles the whole resource indexing livecycle.
func HandleEvents(s Searcher, bus events.Consumer, logger log.Logger, cfg *config.Config) error {
	evts := []events.Unmarshaller{
		events.ItemTrashed{},
		events.ItemRestored{},
		events.ItemMoved{},
		events.ContainerCreated{},
		events.FileTouched{},
		events.FileVersionRestored{},
		events.TagsAdded{},
		events.TagsRemoved{},
	}

	if cfg.Events.AsyncUploads {
		evts = append(evts, events.UploadReady{})
	} else {
		evts = append(evts, events.FileUploaded{})
	}

	ch, err := events.Consume(bus, "search", evts...)
	if err != nil {
		return err
	}

	if cfg.Events.NumConsumers == 0 {
		cfg.Events.NumConsumers = 1
	}

	for i := 0; i < cfg.Events.NumConsumers; i++ {
		go func(s Searcher, ch <-chan interface{}) {
			for e := range ch {
				logger.Debug().Interface("event", e).Msg("updating index")

				spaceId := func(ref *provider.Reference) *provider.ResourceId {
					return &provider.ResourceId{
						StorageId: ref.GetResourceId().GetStorageId(),
						SpaceId:   ref.GetResourceId().GetSpaceId(),
					}
				}

				switch ev := e.(type) {
				case events.ItemTrashed:
					s.TrashItem(ev.ID)
					s.IndexSpace(spaceId(ev.Ref), ev.Executant)
				case events.ItemMoved:
					s.MoveItem(ev.Ref, ev.Executant)
					s.IndexSpace(spaceId(ev.Ref), ev.Executant)
				case events.ItemRestored:
					s.RestoreItem(ev.Ref, ev.Executant)
					s.IndexSpace(spaceId(ev.Ref), ev.Executant)
				case events.ContainerCreated:
					s.IndexSpace(spaceId(ev.Ref), ev.Executant)
				case events.FileTouched:
					s.IndexSpace(spaceId(ev.Ref), ev.Executant)
				case events.FileVersionRestored:
					s.IndexSpace(spaceId(ev.Ref), ev.Executant)
				case events.TagsAdded:
					s.IndexSpace(spaceId(ev.Ref), ev.Executant)
				case events.TagsRemoved:
					s.IndexSpace(spaceId(ev.Ref), ev.Executant)
				case events.FileUploaded:
					s.IndexSpace(spaceId(ev.Ref), ev.Executant)
				case events.UploadReady:
					s.IndexSpace(spaceId(ev.FileRef), ev.ExecutingUser.Id)
				}
			}
		}(
			s,
			ch,
		)
	}

	return nil
}
