angular.module('BoxApp').controller 'MessagesController', ($scope, $http, $q) ->

  url = location.pathname

  $scope.loadMessages = (options) ->
    $scope.loadPostsCanceler?.resolve()
    $scope.loadPostsCanceler = $q.defer()

    $http.get(url.add('.json'), timeout: $scope.loadPostsCanceler.promise, params: options ).success (data) ->
      data.messages.each (obj) ->
        obj.created_at = Date.create(obj.created_at).format('{dd}.{MM}.{yyyy}')
        obj.url = url.add "/#{obj.id}"

      $scope.messages = data.messages
      $scope.loadPostsCanceler = null

  $scope.sentMessage = ->
    $http.post(url, $scope.message).success (data) ->
      $scope.showMessageForm = !$scope.showMessageForm

  # $scope.showMessage = (id, options) ->
  #   $scope.loadPostsCanceler?.resolve()
  #   $scope.loadPostsCanceler = $q.defer()

  #   $http.get(url.add("/#{id}").add('.json'), timeout: $scope.loadPostsCanceler.promise, params: options ).success (data) ->
  #     $scope.show_message = data.message
  #     $scope.showMessage = !$scope.showMessage
  #   $scope.loadPostsCanceler = null