angular.module('BoxApp').factory 'Uploader', ['$rootScope', 'Upload', 'Storage', ($rootScope, Upload, Storage) ->
  class Uploader
    defaultSetting:
      browse_button: 'upload_button'
      runtimes: 'html5,flash'
      flash_swf_url: '/files/Moxie.swf'
      url: '/'

    constructor: (settings = {}) ->
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
          $rootScope.$apply ->
            Object.merge upload, file: file, name: file.name, percent: 0
          @trigger 'fileAdded', upload
        uploader.start()

      @uploader.bind 'uploadProgress', (uploader, file) =>
        upload = @uploads.find (up) -> up.file.id == file.id
        $rootScope.$apply ->
          upload.percent = file.percent
        @trigger 'uploadProgress', upload

      @uploader.bind 'fileUploaded', (uploader, file, resp) =>
        upload = @uploads.find (up) -> up.file.id == file.id
        @removeUpload upload
        $rootScope.$apply ->
          Object.merge upload, JSON.parse(resp.response).upload
          Object.merge upload, state: 'uploaded', file: null
        @trigger 'fileUploaded', upload, resp

    bindUploadsStatusUpdate: ->
      @bind 'fileAdded uploadProgress fileUploaded', ->
        $rootScope.$apply()

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