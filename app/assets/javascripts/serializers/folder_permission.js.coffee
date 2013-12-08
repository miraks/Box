angular.module('rails').factory 'FolderPermissionSerializer', ['railsSerializer', (railsSerializer) ->
  railsSerializer ->
    @resource 'user', 'User'
    @resource 'folder', 'Folder'
]