angular.module('BoxApp').factory 'UploadPermission', ['RailsResource', (RailsResource) ->
  class UploadPermissions extends RailsResource
    @configure
      url: '/api/v1/uploads/{{upload.id}}/permissions'
      name: 'upload_permission'
      serializer: 'UserPermissionSerializer'
      pluralName: 'upload_permissions'

    check: ->
      UploadPermissions.$get @$url('check')
]