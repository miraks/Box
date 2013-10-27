angular.module('BoxApp').factory 'Uploader', ['Upload', (Upload) ->
  class Uploader
    defaultSetting:
      browse_button: 'upload_button'
      runtimes: 'html5,flash'
      flash_swf_url: '/files/Moxie.swf'
      url: '/'

    constructor: ($scope, settings = {}) ->
      @uploads = []

      Object.merge settings, @defaultSetting, 'deep', !'resolve'
      @uploader = new plupload.Uploader settings

      @uploader.init()

      @uploader.bind "filesAdded", (uploader, files) =>
        files.each (file) =>
          upload = new Upload "uploading"
          @uploads.push upload
          $scope.$apply =>
            upload.file = file
            upload.name = file.name
            upload.percent = 0
            @uploadAdded?(upload) if @uploadAdded?
        uploader.start()

      @uploader.bind "uploadProgress", (uploader, file) =>
        upload = @uploads.find (up) -> up.file.id == file.id
        $scope.$apply =>
          upload.percent = file.percent
          @uploadProgress?(upload)

      @uploader.bind "fileUploaded", (uploader, file, resp) =>
        # TODO: process success field in response somehow
        upload = @uploads.find (up) -> up.file.id == file.id
        @uploads.remove upload
        $scope.$apply =>
          upload.state = "uploaded"
          Object.merge upload, resp.upload
          @uploadUploaded?(upload)

    setUrl: (url) ->
      @uploader.settings.url = url

  Uploader
]