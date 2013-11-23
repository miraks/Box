angular.module('BoxApp').factory 'Friend', ['RailsResource', (RailsResource) ->
  class Friend extends RailsResource
    @configure
      url: '/api/v1/users/friends'
      name: 'friend'
      pluralName: 'friends'

    @online = ->
      @$get @$url('online')

    equal: (other) ->
      @constructor? and other.constructor? and
      @constructor.name == other.constructor.name and
      @id? and other.id? and @id == other.id
]