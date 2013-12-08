angular.module('BoxApp').factory 'UserPermission', ['RailsResource', (RailsResource) ->
  class UserPermission extends RailsResource
    @configure
      url: '/api/v1/users/{{user.id}}/permissions'
      name: 'user_permission'
      pluralName: 'user_permissions'
]