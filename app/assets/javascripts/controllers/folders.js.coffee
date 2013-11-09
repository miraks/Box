angular.module('BoxApp').controller 'FoldersController', ['$scope', 'Folder', 'Uploader', 'Upload', 'Clipboard', ($scope, Folder, Uploader, Upload, Clipboard) ->
  $scope.init = (rootId) ->
    currentFolderId = rootId # TODO: read folder id from location first
    $scope.setupUploader()
    $scope.setupClipboard()
    $scope.changeFolder new Folder(id: currentFolderId)

  # Setup

  $scope.setupUploader = ->
    $scope.uploader = new Uploader $scope
    $scope.uploader.bind 'fileAdded', (upload) ->
      $scope.folder.uploads.push upload

  $scope.setupClipboard = ->
    $scope.clipboard = new Clipboard

  # Data load

  $scope.reloadContent = ->
    Folder.get($scope.currentFolder.id).then (folder) ->
      $scope.folder = folder

  # Move around

  $scope.changeFolder = (folder) ->
    $scope.currentFolder = folder
    $scope.cleanSelectedUploads()
    $scope.uploader.setUrl "/api/v1/uploads?folder_id=#{$scope.currentFolder.id}"
    $scope.reloadContent()

  # Uploads selection

  $scope.toggleUploadSelection = (upload) ->
    if $scope.isSelectedUpload upload
      $scope.selectedUploads.remove upload
    else
      $scope.selectedUploads.push upload

  $scope.isSelectedUpload = (upload) ->
    $scope.selectedUploads.indexOf(upload) >= 0

  $scope.cleanSelectedUploads = ->
    $scope.selectedUploads = []

  # Actions with clipboard

  $scope.copy = ->
    $scope.clipboard.copy $scope.selectedUploads

  $scope.cut = ->
    $scope.clipboard.cut $scope.selectedUploads

  $scope.paste = ->
    $scope.clipboard.paste (uploads, mode) ->
      method = switch mode
        when Clipboard.MODE.copy then 'copy'
        when Clipboard.MODE.cut  then 'move'
      Upload[method](uploads, $scope.currentFolder).then (uploads) ->
        $scope.folder.uploads.push uploads...
]