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

# При добавление темплейта в $templateCache сохраняем его имя,
# что бы при начале переходе между страницами с помощью Turbolinks
# восстановить его после перехода
boxApp.run ['$templateCache', 'Storage', ($templateCache, Storage) ->
  templates = Storage.get 'templateCache', {}

  # Восстанавливаем темплейты
  Object.each templates, (key, value) ->
    $templateCache.put key, value

  # Подменяем put что бы сохранять темплейты при добавление,
  # тут может быть проблема, если в ангуляре решат установить
  # лимит на размер $templateCache, но это вряд ли
  oldPut = $templateCache.put
  $templateCache.put = (key, value) ->
    templates[key] = value
    oldPut.call @, key, value
]