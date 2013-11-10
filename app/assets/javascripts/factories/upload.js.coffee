angular.module('BoxApp').factory 'Upload', ['RailsResource', 'Downloader', (RailsResource, Downloader) ->
  class Upload extends RailsResource
    @configure
      url: '/api/v1/uploads'
      name: 'upload'
      pluralName: 'uploads'

    @manipulate = (action, uploads, folder) ->
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

    # TODO: переписать
    equal: (other) ->
      return false unless @state == other.state
      if @id?
        @id == other.id
      else
        @file.id == other.file.id

    download: ->
      Downloader.download @$url('download')
      true
]