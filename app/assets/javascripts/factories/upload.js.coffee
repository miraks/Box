angular.module('BoxApp').factory 'Upload', (RailsResource) ->
  class Upload extends RailsResource
    @configure
      url: '/api/v1/uploads'
      name: 'upload'