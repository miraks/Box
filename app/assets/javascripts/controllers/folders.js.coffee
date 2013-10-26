angular.module('BoxApp').controller 'FoldersController', ($scope, Folder) ->
  $scope.init = (rootId) ->
    currentFolderId = rootId # TODO: read folder id from location first
    $scope.changeFolder new Folder(id: currentFolderId)

  $scope.reloadContent = ->
    Folder.get($scope.currentFolder.id).then (folder) ->
      $scope.folder = folder

  $scope.changeFolder = (folder) ->
    $scope.currentFolder = folder
    $scope.reloadContent()