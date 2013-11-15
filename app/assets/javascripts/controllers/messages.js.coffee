angular.module('BoxApp').controller 'MessagesController', ['$scope', 'Message', 'CurrentUser', ($scope, Message, CurrentUser) ->

  $scope.init = ->
    $scope.message = $scope.newMessage()
    $scope.loadMessages()

  $scope.loadMessages = (message) ->
    Message.get(user: { id: CurrentUser.id }).then (messages) ->
      $scope.messages = messages

  $scope.sentMessage = ->
    $scope.message.create().then (message) ->
      $scope.message = $scope.newMessage()
      $scope.showMessageForm = !$scope.showMessageForm

  $scope.newMessage = ->
    new Message user: { id: CurrentUser.id }

  $scope.init()
]