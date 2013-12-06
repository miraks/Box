angular.module('BoxApp').controller 'ExtensionIconsController', ['$scope', 'ExtensionIcon', ($scope, ExtensionIcon) ->
  $scope.loadIcons = ->
    ExtensionIcon.query().then (icons) ->
      $scope.icons = icons

  $scope.saveNewIcon = ->
    $scope.newIcon.create().then (icon) ->
      $scope.icons.push icon
      $scope.newIcon = new ExtensionIcon

  $scope.deleteIcon = (icon) ->
    icon.delete().then ->
      $scope.icons.remove (i) -> icon.equal i

  $scope.newIcon = new ExtensionIcon
  $scope.loadIcons()
]