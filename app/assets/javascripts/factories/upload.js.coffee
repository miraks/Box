angular.module('BoxApp').factory 'Upload', ['RailsResource', 'AppError', (RailsResource, AppError) ->
  class Upload extends RailsResource
    @configure
      url: '/api/v1/uploads'
      name: 'upload'
      pluralName: 'uploads'
      responseInterceptors: [
        (promise) ->
          # Sometimes it's not a promise
          # should be fixed in RailsResource
          promise.catch? (data) ->
            AppError.create(data).show()
          promise
      ]

    @manipulate = (action, uploads, folder) ->
      uploads = [uploads] unless Object.isArray uploads
      ids = uploads.map 'id'
      @$patch @$url(action), ids: ids, folder_id: folder.id

    @move = (uploads, folder) ->
      @manipulate 'move', uploads, folder

    @copy = (uploads, folder) ->
      @manipulate 'copy', uploads, folder

    constructor: (state) ->
      @state = state || "uploaded"

    ["uploaded", "uploading"].each (state) =>
      @::["is#{state.camelize()}"] = -> @state == state

    equal: (other) ->
      @state == other.state and
      ((@id? and @id == other.id) or
      (@file? and other.file and @file.id == other.file.id))

    permission: ->
      Upload.$get @$url('permission')

    download: (params) ->
      Upload.$get @$url('download'), params
]