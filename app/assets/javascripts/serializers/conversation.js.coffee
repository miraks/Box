angular.module('rails').factory 'ConversationSerializer', ['railsSerializer', (railsSerializer) ->
  railsSerializer ->
    @resource 'messages', 'Message'
    @resource 'lastMessage', 'Message'
]