boxApp = angular.module "boxApp"

boxApp.config ($locationProvider) ->
  $locationProvider.html5Mode true

# Для корректной работы с рельсовой protect_from_forgery
boxApp.config ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')

boxApp.config (RailsResourceProvider) ->
  RailsResourceProvider.updateMethod 'patch'

boxApp.run ($rootScope, $state, $stateParams) ->
  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams

window.boxApp = boxApp