angular.module('BoxApp').factory 'Upload', ['RailsResource', 'Downloader', (RailsResource, Downloader) ->
  class Upload extends RailsResource
    @configure
      url: '/api/v1/uploads'
      name: 'upload'

    constructor: (state) ->
      @state = state || "uploaded"

      ["uploaded", "uploading"].each (state) =>
        @["is#{state.camelize()}"] = -> @state == state

    download: ->
      Downloader.download @$url('download')
      true
]