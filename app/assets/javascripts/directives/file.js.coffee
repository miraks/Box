angular.module('BoxApp').directive "file", ($parse) ->
  restrict: 'A'
  scope:
    file: '='
  link: (scope, element, attrs) ->
    scope.file = element.prop('files')[0]
    element.bind 'change', (event) ->
      file = @files[0]
      scope.$apply ->
        scope.file = file