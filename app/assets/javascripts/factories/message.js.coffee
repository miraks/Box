angular.module('BoxApp').factory 'Message', ['RailsResource', (RailsResource) ->
  class Message extends RailsResource
    @configure
      url: '/api/v1/users/{{userId}}/messages/{{id}}'
      name: 'message'
      pluralName: 'messages'

    received: ->
      Message.$get @.$url('/received')

    sent: ->
      Message.$get @.$url('/sent')

    @beforeResponse (data) ->
      if data.length
        data.each (message) ->
          message.createdAt = Date.create(message.createdAt).format('{dd}.{MM}.{yyyy}')
          message.unread = 'unread' unless message.readAt
]