// Package service contains the web service for the static file server.
package service

import (
	"fmt"
	"net/http"

	"github.com/go-chi/chi/v5"
)

// StaticFileServer defines the inferface for the static file server.
type StaticFileServer interface {
	ServeFile(w http.ResponseWriter, r *http.Request)
}

// New returns the handler for the HTTP service.
func New() http.Handler {
	sfs := Service{}

	router := chi.NewRouter()
	router.Get("/", sfs.ServeFile)

	return router
}

// Service is an implementation of the StaticFileServer interface.
type Service struct{}

func (s Service) ServeFile(w http.ResponseWriter, r *http.Request) {
	fmt.Println("foo")
}
