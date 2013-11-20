angular.module('BoxApp').controller 'ConversationController', ['$scope', 'Conversation', 'Message', 'CurrentUser', ($scope, Conversation, Message, CurrentUser) ->
  $scope.init = (recipient, conversationId) ->
    $scope.recipient = $scope.search.item.slug
    $scope.conversationId = conversationId
    $scope.showMessageForm = true
    $scope.hideRecipientField = true
    $scope.message = $scope.newMessage()
    $scope.loadConversation()

  $scope.loadConversation = ->
    Conversation.get(user: { id: CurrentUser.id }, id: $scope.conversationId).then (conversation) ->
      $scope.conversation = conversation

  $scope.sentMessage = ->
    $scope.message.create().then (message) ->
      $scope.conversation.messages.push message
      $scope.message = $scope.newMessage()

  $scope.newMessage = ->
    new Message user: { id: CurrentUser.id }, recipient: $scope.recipient
]