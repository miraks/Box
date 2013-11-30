angular.module('BoxApp').factory 'AppError', ['Notifier', (Notifier) ->
  class AppError
    constructor: (data) ->
      data = data.data
      name = Object.keys(data).find (key) -> /_error$/.test(key)
      Object.merge @, data[name] || data

    show: ->
      Notifier.show @message || @error
]