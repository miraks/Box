angular.module('BoxApp').controller 'ProcessingStatusController', ['$scope', '$timeout', 'Upload', ($scope, $timeout, Upload) ->
  $scope.checkInterval = 5.seconds()

  $scope.checkStatus = ->
    processingUploads = $scope.processingUploads()
    return $timeout $scope.checkStatus, $scope.checkInterval if processingUploads.isEmpty()
    ids = processingUploads.map 'id'
    Upload.processingStatus(ids).then (statuses) ->
      statuses.each (status) ->
        upload = $scope.folder.uploads.find (up) -> up.id == status.id
        upload.state = status.state
      $timeout $scope.checkStatus, $scope.checkInterval

  $scope.processingUploads = ->
    return [] unless $scope.folder?.uploads?
    $scope.folder.uploads.filter (upload) -> upload.isProcessing()

  $scope.checkStatus()
]