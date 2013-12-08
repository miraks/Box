angular.module('BoxApp').factory 'Folder', ['RailsResource', 'FolderPermission', (RailsResource, FolderPermission) ->
  class Folder extends RailsResource
    @configure
      url: '/api/v1/folders'
      name: 'folder'
      pluralName: 'folders'
      serializer: 'FolderSerializer'

    permission: (params={}) ->
      new FolderPermission Object.merge(params, folder: @)
]