angular.module('BoxApp').controller 'ConversationsController', ['$scope', 'Conversation', 'Message', 'CurrentUser', ($scope, Conversation, Message, CurrentUser) ->
  $scope.init = ->
    $scope.currentUser = CurrentUser
    $scope.message = $scope.newMessage()
    $scope.loadConversations()

  $scope.loadConversations = ->
    Conversation.get(user1: { id: CurrentUser.id }).then (conversations) ->
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

  $scope.loadConversation = (conversation) ->
    Turbolinks.visit "/users/#{CurrentUser.slug}/conversations/#{conversation.lastMessage.other(CurrentUser).slug}"

  $scope.newMessage = ->
    new Message user: { id: CurrentUser.id }

  $scope.recipientSelected = (recipient) ->
    $scope.message.recipient = recipient

  $scope.init()
]