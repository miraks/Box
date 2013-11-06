angular.module('rails').factory 'FriendshipSerializer', ['railsSerializer', (railsSerializer) ->
  railsSerializer ->
    @resource 'friend', 'Friend'
]