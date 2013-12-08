angular.module('BoxApp').controller 'UserPermissionsController', ['$scope', 'UserPermission', 'CurrentUser', ($scope, UserPermission, CurrentUser) ->
  $scope.loadUserPermissions = ->
    UserPermission.query(null, user: { id: CurrentUser.id }).then (permissions) ->
      $scope.permissions = permissions

  $scope.loadUserPermissions()
]