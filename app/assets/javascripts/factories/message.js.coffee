angular.module('BoxApp').factory 'Message', ['RailsResource', (RailsResource) ->
  class Message extends RailsResource
    @configure
      url: '/api/v1/users/{{user.id}}/messages/{{id}}'
      name: 'message'
      pluralName: 'messages'
      serializer: 'MessageSerializer'

    messageProcessor = (message) ->
      message.createdAt = Date.create(message.createdAt).format('{dd}.{MM}.{yyyy}')

    @afterResponse (data) ->
      if Object.isArray data
        data.each (message) -> messageProcessor message
      else
        messageProcessor data

    other: (user) ->
      if @user.id == user.id then @recipient else @user

    equal: (other) ->
      @id? and other.id? and @id == other.id
]