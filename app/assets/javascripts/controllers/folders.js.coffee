angular.module('BoxApp').controller 'FoldersController', ($scope, Folder) ->
  $scope.init = (data) ->
    Object.merge $scope, data
    $scope.currentFolderId = $scope.rootId
    $scope.reloadContent()

  $scope.reloadContent = ->
    Folder.get($scope.currentFolderId).then (folder) ->
      $scope.folder = folder