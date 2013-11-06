angular.module('BoxApp').factory 'Friend', ['RailsResource', (RailsResource) ->
  class Friend extends RailsResource
    @configure
      url: '/api/v1/users/friends'
      name: 'friend'
]