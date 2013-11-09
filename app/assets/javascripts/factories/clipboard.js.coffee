angular.module('BoxApp').factory 'Clipboard', [ ->
  class Clipboard
    MODE =
      none: 0
      copy: 1
      cut: 2
    @MODE = MODE

    constructor: ->
      @clear()

    copy: (data) ->
      @store data, MODE.copy

    cut: (data) ->
      @store data, MODE.cut

    paste: (callback) ->
      return if @mode == MODE.none
      callback @buffer, @mode
      @clear() if @mode == MODE.cut

    clear: ->
      @store null, MODE.none

    store: (data, @mode) ->
      @buffer = data
]