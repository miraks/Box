angular.module('BoxApp').controller 'SpaceUsageController', ['$scope', '$rootScope', 'User', ($scope, $rootScope, User) ->
  $scope.init = (userData) ->
    $scope.user = new User userData
    $scope.bindToUploaderEvents()

  $scope.bindToUploaderEvents = ->
    $scope.uploader.bind 'fileUploaded', (upload) ->
      $scope.$apply ->
        $scope.user.usedSpace += upload.size
]