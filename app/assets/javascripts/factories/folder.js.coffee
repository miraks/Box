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
          promise.catch? (data) ->
            AppError.create(data).show()
          promise
      ]

    permission: ->
      Folder.$get @$url('permission')
]