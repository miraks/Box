angular.module('rails').factory 'UserPermissionSerializer', ['railsSerializer', (railsSerializer) ->
  railsSerializer ->
    @resource 'user', 'User'
]