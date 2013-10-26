angular.module('rails').factory 'FolderSerializer', (railsSerializer) ->
  railsSerializer ->
    @resource 'uploads', 'Upload'
    @resource 'children', 'Folder'
    @resource 'parents', 'Folder'
