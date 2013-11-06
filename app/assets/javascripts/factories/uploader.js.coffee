angular.module('BoxApp').factory 'Uploader', ['Upload', 'Storage', (Upload, Storage) ->
  class Uploader
    defaultSetting:
      browse_button: 'upload_button'
      runtimes: 'html5,flash'
      flash_swf_url: '/files/Moxie.swf'
      url: '/'

    constructor: (@$scope, settings) ->
      @globalUploads = Storage.get 'uploads', []

      @uploads = []
      @callbacks = {}
      Object.merge settings, @defaultSetting, true, false
      @uploader = new plupload.Uploader settings

      @uploader.init()
      @bindCallbacks()
      @bindUploadsStatusUpdate()

    bindCallbacks: ->
      @uploader.bind 'filesAdded', (uploader, files) =>
        files.each (file) =>
          upload = new Upload 'uploading'
          @addUpload upload
          @$scope.$apply ->
            Object.merge upload, file: file, name: file.name, percent: 0
          @trigger 'fileAdded', upload
        uploader.start()

      @uploader.bind 'uploadProgress', (uploader, file) =>
        upload = @uploads.find (up) -> up.file.id == file.id
        @$scope.$apply ->
          upload.percent = file.percent
        @trigger 'uploadProgress', upload

      @uploader.bind 'fileUploaded', (uploader, file, resp) =>
        upload = @uploads.find (up) -> up.file.id == file.id
        @removeUpload upload
        @$scope.$apply ->
          Object.merge upload, resp.upload
          Object.merge upload, state: 'uploaded', file: null
        @trigger 'fileUploaded', upload, resp

    bindUploadsStatusUpdate: ->
      @bind 'fileAdded uploadProgress fileUploaded', ->
        Storage.get('$uploadsStatusScope')?.$apply()

    bind: (eventTypes, callback) ->
      eventTypes.split(' ').each (eventType) =>
        @callbacks[eventType] ||= []
        @callbacks[eventType].push callback

    trigger: (eventType, data...) ->
      @callbacks[eventType]?.each (callback) ->
        callback data...

    addUpload: (upload) ->
      @uploads.push upload
      @globalUploads.push upload

    removeUpload: (upload) ->
      @uploads.remove (up) -> up.equal upload
      @globalUploads.remove (up) -> up.equal upload

    setUrl: (url) ->
      @uploader.settings.url = url
]