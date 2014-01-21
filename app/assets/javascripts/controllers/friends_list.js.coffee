angular.module('BoxApp').controller 'FriendsListController', ['$scope', '$rootScope', 'Friend', 'Storage', 'CurrentUser', ($scope, $rootScope, Friend, Storage, CurrentUser) ->
  $scope.loadFriends = ->
    return unless CurrentUser.isLoggedIn()
    Friend.query().then (friends) ->
      $scope.friends = friends

  $scope.hasFriends = ->
    $scope.friends? and not $scope.friends.isEmpty()

  $rootScope.$on 'friendshipCreated', (event, friendship) ->
    $scope.storage.query?.push friendship.friend
    $scope.storage.online?.push friendship.friend if friendship.friend.online

  $rootScope.$on 'friendshipDestroyed', (event, friendship) ->
    $scope.friends?.remove (friend) -> friend.equal friendship.friend

  $scope.loadFriends()
]