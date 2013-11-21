angular.module('BoxApp').controller 'UserSearchController', ['$scope', 'User', ($scope, User) ->

  $scope.search = ->
    User.search($scope.query).then (result) ->
      $scope.items = result.search

]