angular.module('rails').factory 'UploadPermissionSerializer', ['railsSerializer', (railsSerializer) ->
  railsSerializer ->
    @resource 'user', 'User'
    @resource 'upload', 'Upload'
]