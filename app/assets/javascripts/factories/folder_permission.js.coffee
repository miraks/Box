angular.module('BoxApp').factory 'FolderPermission', ['RailsResource', (RailsResource) ->
  class FolderPermissions extends RailsResource
    @configure
      url: '/api/v1/folders/{{folder.id}}/permissions/{{id}}'
      name: 'folder_permission'
      serializer: 'UserPermissionSerializer'
      pluralName: 'folder_permissions'

    check: ->
      FolderPermissions.$get @$url('check')
]