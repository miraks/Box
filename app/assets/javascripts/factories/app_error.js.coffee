angular.module('BoxApp').factory 'AppError', ['$injector', 'Notifier', ($injector, Notifier) ->
  class AppError
    @create = (data) ->
      if data.status == 500
        klass = $injector.get('InternalError')
        return new klass data
      data = data.data
      name = Object.keys(data).find (key) -> /_error$/.test(key)
      klass = $injector.get name.camelize()
      new klass data[name]

    constructor: (data) ->
      Object.merge @, data

    # redefine in subclasses
    message: "Error!"

    show: ->
      message = @message
      message = message() if Object.isFunction message
      Notifier.show message
]