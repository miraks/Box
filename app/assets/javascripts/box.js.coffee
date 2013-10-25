boxApp = angular.module "boxApp"

boxApp.config ($locationProvider) ->
  $locationProvider.html5Mode true

# for corectly work with rails protect_from_forgery
boxApp.config ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')

boxApp.config ($http) ->
  defaults = $http.defaults.headers
  defaults.patch = defaults.patch || {}
  defaults.patch['Content-Type'] = 'application/json'

boxApp.run ($rootScope, $state, $stateParams) ->
  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams

window.boxApp = boxApp