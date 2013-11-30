angular.module('BoxApp').controller 'FriendsListController', ['$scope', '$rootScope', 'Friend', 'Storage', 'CurrentUser', ($scope, $rootScope, Friend, Storage, CurrentUser) ->
  $scope.loadFriends = (filter) ->
    return unless CurrentUser.isLoggedIn()
    filter = $scope.currentFilter
    filter = 'query' if filter == 'all'
    return $scope.friends = $scope.storage[filter] if $scope.storage[filter]?
    Friend[filter]().then (friends) ->
      $scope.friends = friends
      $scope.storage[filter] = $scope.friends

  $scope.hasFriends = ->
    $scope.friends? and not $scope.friends.isEmpty()

  $scope.changeFilter = (newFilter) ->
    $scope.currentFilter = newFilter
    $scope.loadFriends()

  $rootScope.$on 'friendshipCreated', (event, friendship) ->
    $scope.storage.query?.push friendship.friend
    $scope.storage.online?.push friendship.friend if friendship.friend.online

  $rootScope.$on 'friendshipDestroyed', (event, friendship) ->
    ['query', 'online'].each (filter) ->
      $scope.storage[filter]?.remove (friend) -> friend.equal friendship.friend

  $scope.storage = Storage.get 'friends', {}
  $scope.changeFilter 'online'
]