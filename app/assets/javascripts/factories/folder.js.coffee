angular.module('BoxApp').factory 'Folder', ['RailsResource', (RailsResource) ->
  class Folder extends RailsResource
    @configure
      url: '/api/v1/folders'
      name: 'folder'
      pluralName: 'folders'
      serializer: 'FolderSerializer'

    permission: ->
      Folder.$get @$url('permission')
]