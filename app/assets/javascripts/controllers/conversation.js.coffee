angular.module('BoxApp').controller 'ConversationController', ['$scope', 'Message', ($scope, Message) ->
  $scope.init = (userId, recipientId, conversationId) ->
    $scope.userId = userId
    $scope.recipientId = recipientId
    $scope.conversationId = conversationId
    $scope.showMessageForm = true
    $scope.hideRecipientField = true
    $scope.message = $scope.newMessage()
    $scope.loadMessages()

  $scope.loadMessages = ->
    Message.get(user: { id: $scope.userId }, id: $scope.conversationId).then (messages) ->
      $scope.messages = messages

  $scope.sentMessage = ->
    $scope.message.create().then (message) ->
      $scope.messages.push message
      $scope.message = $scope.newMessage()

  $scope.newMessage = ->
    new Message user: { id: $scope.userId }, recipientId: $scope.recipientId
]