angular.module('BoxApp').controller 'SpaceLimitsController', ['$scope', 'User', ($scope, User) ->
  $scope.loadUsers = ->
    User.query().then (users) ->
      $scope.users = users

  $scope.saveUser = (user) ->
    user.save()

  $scope.loadUsers()
]