boxApp = angular.module 'BoxApp', ['rails']

boxApp.config ['$locationProvider', ($locationProvider) ->
  $locationProvider.html5Mode true
]

# Для корректной работы с рельсовой protect_from_forgery
boxApp.config ['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name=csrf-token]').content
]

boxApp.config ['RailsResourceProvider', (RailsResourceProvider) ->
  RailsResourceProvider.updateMethod 'patch'
]
