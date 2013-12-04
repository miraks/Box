angular.module('rails').factory 'ConversationSerializer', ['railsSerializer', (railsSerializer) ->
  railsSerializer ->
    @resource 'messages', 'Message'
    @resource 'lastMessage', 'Message'
    @resource 'user1', 'User'
    @resource 'user2', 'User'
]