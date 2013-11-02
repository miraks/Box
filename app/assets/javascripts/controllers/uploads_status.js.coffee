angular.module('BoxApp').controller 'UploadsStatusController', ['$scope', ($scope) ->
  # TODO: Подумать над способом получше для сохранения
  #       загрузок при переходе между страницами
  window.box.uploads ||= []
  window.box.$uploadsStatusScope = $scope
  $scope.uploads = window.box.uploads
]