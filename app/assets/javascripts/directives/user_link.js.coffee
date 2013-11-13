angular.module('BoxApp').directive 'userLink', ->
  restrict: 'E'
  scope:
    user: '='
  templateUrl: '/assets/user_link.html'
  replace: true