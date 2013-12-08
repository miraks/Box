angular.module('BoxApp').factory 'FolderPermission', ['RailsResource', (RailsResource) ->
  class FolderPermissions extends RailsResource
    @configure
      url: '/api/v1/folders/{{folder.id}}/permissions/{{id}}'
      name: 'folder_permission'
      pluralName: 'folder_permissions'
      serializer: 'FolderPermissionSerializer'

    check: ->
      FolderPermissions.$get @$url('check')
]