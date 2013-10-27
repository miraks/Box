angular.module('BoxApp').factory 'Upload', ['RailsResource', (RailsResource) ->
  class Upload extends RailsResource
    @configure
      url: '/api/v1/uploads'
      name: 'upload'

    constructor: (state) ->
      @state = state || "uploaded"

      ["uploaded", "uploading"].each (state) =>
        @["is#{state.camelize()}"] = -> @state == state
]