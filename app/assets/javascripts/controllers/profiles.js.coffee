angular.module('BoxApp').controller 'ProfilesController', ['$scope', '$http', 'User', ($scope, $http, User) ->
  $scope.init = (params) ->
    $scope.user = new User params

  $scope.submit = ->
    $scope.user.update()

  $scope.init()
]