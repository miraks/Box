angular.module('BoxApp').factory 'Conversation', ['RailsResource', (RailsResource) ->
  class Conversation extends RailsResource
    @configure
      url: '/api/v1/users/{{user1.id}}/conversations/{{user2.id}}'
      name: 'conversation'
      pluralName: 'conversations'
      serializer: 'ConversationSerializer'

    conversationProcessor = (conversation) ->
      conversation.updatedAt = Date.create(conversation.updatedAt).format('{dd}.{MM}.{yyyy}')

    @afterResponse (data) ->
      if Object.isArray data
        data.each (conversation) -> conversationProcessor conversation
      else
        conversationProcessor data

    other: (user) ->
      if @user1.id == user.id then @user2 else @user1
]