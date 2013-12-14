angular.module('BoxApp').controller 'ProfilesController', ['$scope', 'User', ($scope, User) ->
  $scope.init = (params) ->
    $scope.user = new User params

  $scope.submit = ->
    $scope.user.update()

  $scope.init()
]