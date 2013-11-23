angular.module('BoxApp').controller 'FriendsListController', ['$scope', 'Friend', 'Storage', 'CurrentUser', ($scope, Friend, Storage, CurrentUser) ->
  $scope.loadFriends = (filter) ->
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

  $scope.storage = Storage.get 'friends', {}
  $scope.changeFilter 'online'
]