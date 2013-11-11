angular.module('BoxApp').controller 'MessagesController', ['$scope', 'Message', ($scope, Message) ->

  $scope.init = (userId) ->
    $scope.userId = userId
    $scope.message = $scope.newMessage()
    $scope.loadReceivedMessages()

  $scope.loadReceivedMessages = ->
    Message.received($scope.userId).then (messages) ->
      $scope.messages = messages

  $scope.loadSentMessages = ->
    Message.sent($scope.userId).then (messages) ->
      $scope.messages = messages

  $scope.loadMessage = (message) ->
    Message.get(message).then (message) ->
      message.unread = false

  $scope.sentMessage = ->
    $scope.message.create().then (message) ->
      $scope.message = $scope.newMessage()
      $scope.showMessageForm = !$scope.showMessageForm

  $scope.newMessage = ->
    new Message user: { id: $scope.userId }
]