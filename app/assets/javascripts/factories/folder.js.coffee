angular.module('BoxApp').factory 'Folder', ['RailsResource', (RailsResource) ->
  class Folder extends RailsResource
    @configure
      url: '/api/v1/folders'
      name: 'folder'
      pluralName: 'folders'
      serializer: 'FolderSerializer'

    permission: ->
      Folder.$get @$url('permission')

    set_permissions: (users) ->
      ids = users.map 'id'
      Folder.$patch @$url('set_permissions'), ids: ids

    get_permissions: ->
      Folder.$get @$url('get_permissions')
]