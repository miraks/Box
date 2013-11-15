angular.module('BoxApp').controller 'ConversationController', ['$scope', 'Message', 'CurrentUser', ($scope, Message, CurrentUser) ->
  $scope.init = (recipientId, conversationId) ->
    $scope.recipientId = recipientId
    $scope.conversationId = conversationId
    $scope.showMessageForm = true
    $scope.hideRecipientField = true
    $scope.message = $scope.newMessage()
    $scope.loadMessages()

  $scope.loadMessages = ->
    Message.get(user: { id: CurrentUser.id }, id: $scope.conversationId).then (messages) ->
      $scope.messages = messages

  $scope.sentMessage = ->
    $scope.message.create().then (message) ->
      $scope.messages.push message
      $scope.message = $scope.newMessage()

  $scope.newMessage = ->
    new Message user: { id: CurrentUser.id }, recipientId: $scope.recipientId
]