angular.module('BoxApp').controller 'FoldersController', ['$scope', 'Folder', 'Uploader', 'Upload', 'Clipboard', 'Notifier', ($scope, Folder, Uploader, Upload, Clipboard, Notifier) ->
  $scope.init = (rootId, currentUserId) ->
    currentFolderId = rootId # TODO: read folder id from location first
    $scope.currentUserId = currentUserId # TODO: remove later
    $scope.setupUploader()
    $scope.setupClipboard()
    $scope.changeFolder new Folder(id: currentFolderId)

  # Setup

  $scope.setupUploader = ->
    $scope.uploader = new Uploader
    $scope.uploader.bind 'fileAdded', (upload) ->
      $scope.folder.uploads.push upload

  $scope.setupClipboard = ->
    $scope.clipboard = new Clipboard

  # Data load

  $scope.reloadContent = ->
    Folder.get($scope.currentFolder.id).then (folder) ->
      $scope.folder = folder

  # Downloading

  $scope.download = (upload) ->
    params = { password: prompt("Введи пароль") } if upload.locked and upload.user.id != $scope.currentUserId
    upload.download params

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

  # Password manipulation

  $scope.setPassword = (object) ->
    password = prompt "Введи пароль"
    return unless password?
    object.password = password
    object.update().then (object) ->
      delete object.password
      Notifier.show 'Пароль установлен'

  $scope.deletePassword = (object) ->
    object.password = null
    object.update().then (object) ->
      Notifier.show 'Пароль удален'

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