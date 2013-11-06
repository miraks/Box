angular.module('BoxApp').controller 'FriendsListController', ['$scope', 'Friend', 'Storage', ($scope, Friend, Storage) ->
  $scope.loadFriends = ->
    return $scope.friends = Storage.get 'friends' if Storage.has 'friends'
    Friend.query().then (data) ->
      $scope.friends = data.friends
      Storage.store 'friends', $scope.friends

  $scope.hasFriends = ->
    $scope.friends? and not $scope.friends.isEmpty()

  $scope.loadFriends()
]