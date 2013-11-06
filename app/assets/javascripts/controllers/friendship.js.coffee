angular.module('BoxApp').controller 'FriendshipController', ['$scope', 'Friendship', 'Storage', ($scope, Friendship, Storage) ->
  $scope.init = (params) ->
    params = JSON.parse(params) if params?
    $scope.friendship = new Friendship params

  $scope.becomeFriend = ->
    friendship = $scope.friendship.create().then (friendship) ->
      $scope.friendship = friendship
      Storage.get('friends')?.push $scope.friendship.friend

  $scope.stopBeingFriend = ->
    $scope.friendship.delete().then (friendship) ->
      $scope.friendship = friendship
      Storage.get('friends')?.remove (friend) -> friendship.friend.equal friend
      friendship.id = null

  $scope.isFriend = ->
    not $scope.friendship.isNew()
]