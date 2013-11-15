angular.module('BoxApp').controller 'ConversationsController', ['$scope', 'Conversation', 'Message', 'CurrentUser', ($scope, Conversation, Message, CurrentUser) ->
  $scope.init = ->
    $scope.currentUser = CurrentUser
    $scope.message = $scope.newMessage()
    $scope.loadConversations()

  $scope.loadConversations = ->
    Conversation.get(user: { id: CurrentUser.id }).then (conversations) ->
      $scope.conversations = conversations

  $scope.sentMessage = ->
    $scope.message.create().then (message) ->
      $scope.addMessage message
      $scope.message = $scope.newMessage()
      $scope.showMessageForm = !$scope.showMessageForm

  $scope.addMessage = (message) ->
    conversation = $scope.conversations.find (conv) -> conv.id == message.conversationId
    return conversation.lastMessage = message if conversation?
    conversation = new Conversation
      id: message.conversationId
      updatedAt: message.createdAt
      lastMessage: message
      unread: false
    $scope.conversations.unshift conversation

  $scope.newMessage = ->
    new Message user: { id: CurrentUser.id }

  $scope.init()
]