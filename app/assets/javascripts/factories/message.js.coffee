angular.module('BoxApp').factory 'Message', ['RailsResource', (RailsResource) ->
  class Message extends RailsResource
    @configure
      url: '/api/v1/users/{{user.id}}/messages/{{id}}'
      name: 'message'
      pluralName: 'messages'
      serializer: 'MessageSerializer'

    messageProcessor = (message) ->
      message.createdAt = Date.create(message.createdAt).format('{dd}.{MM}.{yyyy}')
      message.unread = 'unread' unless message.readAt

    @afterResponse (data) ->
      if Object.isArray data
        data.each (message) -> messageProcessor message
      else
        messageProcessor data

    @received = (userId) ->
      @$get @$url(user: { id: userId }, 'received')

    @sent = (userId) ->
      @$get @$url(user: { id: userId }, 'sent')
]