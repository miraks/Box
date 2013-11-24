angular.module('BoxApp').controller 'FriendshipController', ['$scope', 'Friendship', 'Storage', ($scope, Friendship, Storage) ->
  $scope.init = (params) ->
    params = JSON.parse(params) if params?
    $scope.friendship = new Friendship params

  $scope.becomeFriend = ->
    friendship = $scope.friendship.create().then (friendship) ->
      $scope.friendship = friendship
      $scope.$emit 'friendshipCreated', $scope.friendship

  $scope.stopBeingFriend = ->
    $scope.friendship.delete().then (friendship) ->
      $scope.friendship = friendship
      $scope.$emit 'friendshipDestroyed', $scope.friendship
      friendship.id = null

  $scope.isFriend = ->
    not $scope.friendship.isNew()
]