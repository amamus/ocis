// Package service contains the web service for the static file server.
package service

import (
	"errors"
	"io"
	"net/http"
	"os"
	"path/filepath"

	"github.com/go-chi/chi/v5"
	"github.com/owncloud/ocis/v2/ocis-pkg/config/defaults"
)

const (
	_mb = 1024 * 1024 // 1 MB
)

var (
	_storagePath = filepath.Join(defaults.BaseDataPath(), "static-file-server")
)

// StaticFileServer defines the inferface for the static file server.
type StaticFileServer interface {
	ServeFile(w http.ResponseWriter, r *http.Request)
	UploadLogo(w http.ResponseWriter, r *http.Request)
}

// New returns the handler for the HTTP service.
func New() http.Handler {
	sfs := Service{}

	router := chi.NewRouter()
	router.Post("/branding", sfs.UploadLogo)

	fs := http.FileServer(http.Dir(_storagePath))
	router.Mount("/", fs)

	return router
}

// Service is an implementation of the StaticFileServer interface.
type Service struct{}

// UploadLogo implements to endpoint to upload branding assets
func (s Service) UploadLogo(w http.ResponseWriter, r *http.Request) {
	file, fileHeader, err := r.FormFile("logo")
	if err != nil {
		if errors.Is(err, http.ErrMissingFile) {
			w.WriteHeader(http.StatusBadRequest)
		}
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	defer file.Close()

	dst, err := createFile(filepath.Join(_storagePath, "branding", filepath.Join("/", fileHeader.Filename)))
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
	defer dst.Close()

	_, err = io.Copy(dst, file)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
}

// createFile creates new files. If the given path contains directories which do not exist
// they will also be created.
func createFile(path string) (*os.File, error) {
	if err := os.MkdirAll(filepath.Dir(path), 0770); err != nil {
		return nil, err
	}
	return os.Create(path)
}
