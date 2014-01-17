angular.module('BoxApp').controller 'FoldersController', ['$scope', '$rootScope', 'Folder', 'Uploader', 'Upload', 'Clipboard', 'Notifier', 'Downloader', 'CurrentUser', 'FolderPermission', 'UploadPermission', 'AudioPlayer', ($scope, $rootScope, Folder, Uploader, Upload, Clipboard, Notifier, Downloader, CurrentUser, FolderPermissions, UploadPermissions, AudioPlayer) ->
  $scope.init = (rootId, setupUploder) ->
    currentFolderId = rootId # TODO: read folder id from location first
    $scope.setupUploader() if setupUploder
    $scope.setupClipboard()
    $scope.bindDropCallbacks()
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
      $scope.cleanSelected()
      $scope.uploader?.setUrl "/api/v1/uploads?folder_id=#{$scope.currentFolder.id}"
      $scope.reloadContent params
    if checkPermission then $scope.checkPermission folder, actions else actions()

  $scope.reloadContent = (params) ->
    Folder.get($scope.currentFolder.id, params).then (folder) ->
      $scope.folder = folder

  # Actions with upload

  $scope.download = (upload) ->
    $scope.checkPermission upload, (params) ->
      upload.download(params).then (upload) ->
        Downloader.download upload.url

  $scope.deleteUpload = (upload) ->
    upload.delete().then ->
      $scope.folder.uploads.remove (up) -> up.equal upload

  # Selections

  $scope.selectedObjects = ->
    if $scope.selectedFolders.isEmpty() then $scope.selectedUploads else $scope.selectedFolders

  $scope.toggleFolderSelection = (folder) ->
    $scope.cleanSelectedUploads()
    if $scope.isSelectedFolder folder
      $scope.selectedFolders.remove folder
    else
      $scope.selectedFolders.push folder

  $scope.toggleUploadSelection = (upload) ->
    $scope.cleanSelectedFolders()
    if $scope.isSelectedUpload upload
      $scope.selectedUploads.remove upload
    else
      $scope.selectedUploads.push upload

  $scope.isSelectedFolder = (folder) ->
    $scope.selectedFolders.indexOf(folder) >= 0

  $scope.isSelectedUpload = (upload) ->
    $scope.selectedUploads.indexOf(upload) >= 0

  $scope.cleanSelectedFolders = ->
    $scope.selectedFolders = []

  $scope.cleanSelectedUploads = ->
    $scope.selectedUploads = []

  $scope.cleanSelected = ->
    $scope.cleanSelectedFolders()
    $scope.cleanSelectedUploads()

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

  $scope.delete = ->
    $scope.selectedUploads.map (upload) ->
      $scope.deleteUpload upload

  $scope.itemSettings = ->
    object = $scope.selectedObjects().last()
    $scope.loadPermissions object if object?

  $scope.lock = ->
    $scope.setPassword $scope.selectedUploads.last()

  $scope.unlock = ->
    $scope.selectedUploads.map (upload) ->
      $scope.deletePassword upload

  $scope.downloadItem = ->
    $scope.download $scope.selectedUploads.last()

  $scope.play = ->
    $scope.playAudio $scope.selectedUploads.last()

  $scope.toPlaylist = ->
    $scope.selectedUploads.map (upload) ->
      $scope.addToPlaylist upload

  $scope.addFolder = ->
  $scope.deleteFolder = ->
  $scope.renameFolder = ->
  $scope.moveFolder = ->

  # Drag and drop

  $scope.dropped = (upload, folder) ->
    return if upload.folderId == folder.id
    action = if upload.userId == $scope.folder.userId then 'move' else 'copy'
    Upload[action](upload, folder).then (uploads) ->
      upload = uploads[0]
      $rootScope.$emit "folders.upload#{action}", [upload, folder]

  $scope.bindDropCallbacks = ->
    addUpload = (upload, folder) ->
      $scope.folder.uploads.push upload if $scope.folder.id == folder.id

    $rootScope.$on 'folders.uploadmove', (event, data) ->
      [upload, folder] = data
      addUpload upload, folder
      $scope.folder.uploads.remove((up) -> up.equal(upload)) unless $scope.folder.id == folder.id

    $rootScope.$on 'folders.uploadcopy', (event, data) ->
      [upload, folder] = data
      addUpload upload, folder

  # AudioPlayer

  $scope.playAudio = (upload) ->
    $scope.checkPermission upload, (params) ->
      upload.download(params).then (upload) ->
        AudioPlayer.playNow upload.name, upload.sources

  $scope.addToPlaylist = (upload) ->
    $scope.checkPermission upload, (params) ->
      upload.download(params).then (upload) ->
        AudioPlayer.addToPlaylist upload.name, upload.sources
]
