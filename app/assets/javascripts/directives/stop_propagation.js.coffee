angular.module('BoxApp').directive 'stopPropagation', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind attrs.stopPropagation, (event) ->
      event.stopPropagation()