angular.module('BoxApp').factory 'Friend', ['RailsResource', (RailsResource) ->
  class Friend extends RailsResource
    @configure
      url: '/api/v1/users/friends'
      name: 'friend'
      pluralName: 'friends'

    equal: (other) ->
      @constructor? and other.constructor? and
      @constructor.name == other.constructor.name and
      @id? and other.id? and @id == other.id
]