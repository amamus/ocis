package command

import (
	"github.com/owncloud/ocis/v2/ocis-pkg/config"
	"github.com/owncloud/ocis/v2/ocis-pkg/config/configlog"
	"github.com/owncloud/ocis/v2/ocis-pkg/config/parser"
	"github.com/owncloud/ocis/v2/ocis/pkg/command/helper"
	"github.com/owncloud/ocis/v2/ocis/pkg/register"
	"github.com/owncloud/ocis/v2/services/static-file-server/pkg/command"
	"github.com/urfave/cli/v2"
)

// StaticCommand is the entrypoint for the static command.
func StaticCommand(cfg *config.Config) *cli.Command {
	return &cli.Command{
		Name:     cfg.StaticFileServer.Service.Name,
		Usage:    helper.SubcommandDescription(cfg.StaticFileServer.Service.Name),
		Category: "services",
		Before: func(c *cli.Context) error {
			configlog.Error(parser.ParseConfig(cfg, true))
			cfg.StaticFileServer.Commons = cfg.Commons
			return nil
		},
		Subcommands: command.GetCommands(cfg.StaticFileServer),
	}
}

func init() {
	register.AddCommand(StaticCommand)
}
