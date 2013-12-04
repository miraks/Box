angular.module('BoxApp').controller 'ConversationController', ['$scope', 'Conversation', 'Message', 'CurrentUser', ($scope, Conversation, Message, CurrentUser) ->
  $scope.init = (recipientId) ->
    $scope.recipientId = recipientId
    $scope.hideRecipientField = true
    $scope.message = $scope.newMessage()
    $scope.loadConversation()

  $scope.loadConversation = ->
    Conversation.get(user1: { id: CurrentUser.id }, user2: { id: $scope.recipientId }).then (conversation) ->
      $scope.conversation = conversation

  $scope.sentMessage = ->
    $scope.message.create().then (message) ->
      $scope.conversation.messages.unshift message
      $scope.message = $scope.newMessage()

  $scope.deleteMessage = (message) ->
    message.remove().then (message) ->
      $scope.conversation.messages.remove (mes) -> mes.equal message

  $scope.newMessage = ->
    new Message user: { id: CurrentUser.id }, recipientId: $scope.recipientId
]