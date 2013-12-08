angular.module('BoxApp').factory 'UploadPermission', ['RailsResource', (RailsResource) ->
  class UploadPermissions extends RailsResource
    @configure
      url: '/api/v1/uploads/{{upload.id}}/permissions/{{id}}'
      name: 'upload_permission'
      serializer: 'UploadPermissionSerializer'
      pluralName: 'upload_permissions'

    check: ->
      UploadPermissions.$get @$url('check')
]