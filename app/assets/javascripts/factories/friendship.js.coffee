angular.module('BoxApp').factory 'Friendship', ['RailsResource', 'railsSerializer', (RailsResource, railsSerializer) ->
  class Friendship extends RailsResource
    @configure
      url: '/api/v1/users/{{friend.id}}/friendships'
      name: 'friendship'
      pluralName: 'friendships'
      serializer: 'FriendshipSerializer'
]