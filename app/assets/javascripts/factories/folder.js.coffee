angular.module('BoxApp').factory 'Folder', (RailsResource) ->
  class Folder extends RailsResource
    @configure
      url: '/api/v1/folders'
      name: 'folder'
      serializer: 'FolderSerializer'