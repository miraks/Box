angular.module('BoxApp').controller 'ProfilesController', ['$scope', 'User', ($scope, User) ->
  $scope.init = (params) ->
    $scope.user = new User params
    console.log $scope.user

  $scope.submit = ->
    $scope.user.update()

  $scope.init()
]