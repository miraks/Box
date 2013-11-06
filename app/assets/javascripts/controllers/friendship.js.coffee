angular.module('BoxApp').controller 'FriendshipController', ['$scope', 'Friendship', 'Storage', ($scope, Friendship, Storage) ->
  $scope.init = (params) ->
    $scope.friendship = new Friendship params

  $scope.becomeFriend = ->
    $scope.friendship.create()

  $scope.stopBeingFriend = ->
    $scope.friendship.delete()

  $scope.isFriend = ->
    not $scope.friendship.isNew()
]