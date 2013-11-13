angular.module('BoxApp').factory 'Folder', ['RailsResource', 'AppError', (RailsResource, AppError) ->
  class Folder extends RailsResource
    @configure
      url: '/api/v1/folders'
      name: 'folder'
      pluralName: 'folders'
      serializer: 'FolderSerializer'
      responseInterceptors: [
        (promise) ->
          # Sometimes it's not a promise
          # should be fixed in RailsResource
          return promise unless promise.catch?
          promise.catch (data) ->
            AppError.create(data).show()
      ]

    @beforeResponse (data) ->
      format = "long"
      ["createdAt", "UpdatedAt"].each (field) ->
        data[field] = Date.create(data[field]).format(format)
]