angular.module('BoxApp').controller 'MessagesController', ['$scope', 'Message', ($scope, Message) ->

  $scope.init = (userId, recipientId) ->
    $scope.userId = userId
    $scope.message = $scope.newMessage()
    $scope.loadMessages()

  $scope.loadMessages = (message) ->
    Message.get(user: { id: $scope.userId }).then (messages) ->
      $scope.messages = messages

  $scope.sentMessage = ->
    $scope.message.create().then (message) ->
      $scope.message = $scope.newMessage()
      $scope.showMessageForm = !$scope.showMessageForm

  $scope.newMessage = ->
    new Message user: { id: $scope.userId }
]