angular.module('BoxApp').factory 'Friendship', ['RailsResource', (RailsResource) ->
  class Friendship extends RailsResource
    @configure
      url: '/api/v1/users/{{friendId}}/friendships'
      name: 'friendship'

      afterResponseInterceptors: [ (promise) ->
        promise.then (friendship) ->
          friendship.friends = not friendship.friends
        , (reason) ->
          # TODO: показывать сообщение при неудаче
      ]

    isNew: ->
      not @friends
]