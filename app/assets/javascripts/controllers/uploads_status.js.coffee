angular.module('BoxApp').controller 'UploadsStatusController', ['$scope', 'Storage', ($scope, Storage) ->
  Storage.store '$uploadsStatusScope', $scope
  $scope.uploads = Storage.get 'uploads', []
]