angular.module('BoxApp').controller 'MessagesController', ['$scope', 'Message', ($scope, Message) ->

  $scope.init = (params) ->
    $scope.userId = params.userId
    $scope.message = new Message params
    $scope.loadReceivedMessages()

  $scope.loadReceivedMessages = ->
    $scope.message.received().then (messages) ->
      $scope.messages = messages

  $scope.loadSentMessages = ->
    $scope.message.sent().then (messages) ->
      $scope.messages = messages

  $scope.loadMessage = (id) ->
    Message.get(userId: $scope.userId, id: id).then (response) ->

  $scope.sentMessage = ->
    $scope.message.create().then (response) ->
      $scope.showMessageForm = !$scope.showMessageForm
]