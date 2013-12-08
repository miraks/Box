angular.module('BoxApp').controller 'FoldersController', ['$scope', 'Folder', 'Uploader', 'Upload', 'Clipboard', 'Notifier', 'Downloader', 'CurrentUser', 'FolderPermission', 'UploadPermission', ($scope, Folder, Uploader, Upload, Clipboard, Notifier, Downloader, CurrentUser, FolderPermissions, UploadPermissions) ->
  $scope.init = (rootId, setupUploder) ->
    currentFolderId = rootId # TODO: read folder id from location first
    $scope.setupUploader() if setupUploder
    $scope.setupClipboard()
    $scope.usersList = []
    $scope.changeFolder new Folder(id: currentFolderId), false

  # Setup

  $scope.setupUploader = ->
    $scope.uploader = new Uploader
    $scope.uploader.bind 'fileAdded', (upload) ->
      $scope.folder.uploads.push upload

  $scope.setupClipboard = ->
    $scope.clipboard = new Clipboard

  # Move around

  $scope.changeFolder = (folder, checkPermission = true) ->
    actions = (params) ->
      $scope.currentFolder = folder
      $scope.cleanSelectedUploads()
      $scope.uploader?.setUrl "/api/v1/uploads?folder_id=#{$scope.currentFolder.id}"
      $scope.reloadContent params
    if checkPermission then $scope.checkPermission folder, actions else actions()

  $scope.reloadContent = (params) ->
    Folder.get($scope.currentFolder.id, params).then (folder) ->
      $scope.folder = folder

  # Downloading

  $scope.download = (upload) ->
    $scope.checkPermission upload, (params) ->
      upload.download(params).then (upload) ->
        Downloader.download upload.url

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

  # Permissions
  $scope.checkPermission = (object, callback) ->
    object.permission().check().then (obj) ->
      return Notifier.show "Доступ запрещен" if obj.permission == 'no'
      params = {}
      if obj.permission == 'password'
        params.password = prompt "Введи пароль"
        return unless params.password?
      callback params

  $scope.loadPermissions = (object) ->
    $scope.showSettings = !$scope.showSettings
    $scope.currentItem = object
    context = {}
    context[object.constructor.config.name] = object
    $scope.currentItem.permission().constructor.query(null, context).then (permissions) ->
      $scope.permissions = permissions

  $scope.userSelected = (user) ->
    $scope.currentItem.permission(user: user).create().then (permission) ->
      $scope.permissions.push permission

  $scope.removePermission = (permission) ->
    permission.delete().then ->
      $scope.permissions.remove (p) ->
        p.id == permission.id

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

  # Drag and drop

  $scope.dropped = (upload, folder) ->
    Upload.move(upload, folder).then (uploads) ->
      upload = uploads[0]
      $scope.folder.uploads.remove (up) -> up.equal upload
]