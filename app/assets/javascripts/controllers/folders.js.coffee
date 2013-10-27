angular.module('BoxApp').controller 'FoldersController', ($scope, Folder, Uploader) ->

  $scope.init = (rootId) ->
    currentFolderId = rootId # TODO: read folder id from location first
    $scope.setupUploader()
    $scope.changeFolder new Folder(id: currentFolderId)

  $scope.setupUploader = ->
    $scope.uploader = new Uploader $scope
    $scope.uploader.uploadAdded = (upload) ->
      $scope.folder.uploads.push upload

  $scope.reloadContent = ->
    Folder.get($scope.currentFolder.id).then (folder) ->
      $scope.folder = folder

  $scope.changeFolder = (folder) ->
    $scope.currentFolder = folder
    $scope.updateUploader()
    $scope.reloadContent()

  $scope.updateUploader = ->
    $scope.uploader.setUrl "/api/v1/uploads?folder_id=#{$scope.currentFolder.id}"
