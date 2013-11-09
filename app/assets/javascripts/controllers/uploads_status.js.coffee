angular.module('BoxApp').controller 'UploadsStatusController', ['$scope', 'Storage', ($scope, Storage) ->
  $scope.uploads = Storage.get 'uploads', []
]