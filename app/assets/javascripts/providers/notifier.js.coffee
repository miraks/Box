angular.module('BoxApp').provider 'Notifier', [ ->
  class Notifier
    @$get = ->
      new @

    show: (message) ->
      # TODO: Заменить alert на что-нибудь
      alert message
]