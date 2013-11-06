angular.module('BoxApp').controller 'MessagesController', ($scope, $http, $q) ->

  url = location.pathname

  $scope.loadMessages = (options) ->
    $scope.loadPostsCanceler?.resolve()
    $scope.loadPostsCanceler = $q.defer()

    $http.get(url.add('.json'), timeout: $scope.loadPostsCanceler.promise, params: options ).success (data) ->
      data.messages.each (obj) ->
        obj.created_at = Date.create(obj.created_at).format('{dd}.{MM}.{yyyy}')
        obj.url = url.add "/#{obj.id}"
        obj.unread = 'unread' unless obj.read_at

      $scope.messages = data.messages
      $scope.loadPostsCanceler = null

  $scope.sentMessage = ->
    $http.post(url, $scope.message).success (data) ->
      $scope.showMessageForm = !$scope.showMessageForm