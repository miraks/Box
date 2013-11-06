angular.module('BoxApp').factory 'Folder', ['RailsResource', (RailsResource) ->
  class Folder extends RailsResource
    @configure
      url: '/api/v1/folders'
      name: 'folder'
      pluralName: 'folders'
      serializer: 'FolderSerializer'

    @beforeResponse (data) ->
      format = "long"
      ["createdAt", "UpdatedAt"].each (field) ->
        data[field] = Date.create(data[field]).format(format)
]