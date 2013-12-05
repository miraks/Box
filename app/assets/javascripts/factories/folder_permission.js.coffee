angular.module('BoxApp').factory 'FolderPermission', ['RailsResource', (RailsResource) ->
  class FolderPermissions extends RailsResource
    @configure
      url: '/api/v1/folders/{{folder.id}}/permissions'
      name: 'folder_permission'

    check: ->
      FolderPermissions.$get @$url('check')
]