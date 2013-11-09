angular.module('BoxApp').service 'Clipboard', [ ->
  class Clipboard
    MODES =
      none: 0
      copy: 1
      cut: 2

    constructor: ->
      debugger
      @clear()
      @callbacks = {}

    copy: (data) ->
      @store data, MODES.copy

    cut: (data) ->
      @store data, MODES.cut

    paste: ->
      return if @mode == MODES.none
      @trigger 'paste', @buffer
      @clear() if @mode == MODES.cut

    on: (eventTypes, callback) ->
      eventTypes.split(' ').each (eventType) =>
        @callbacks[eventType] ||= []
        @callbacks[eventType].push callback

    trigger: (eventType, data) ->
      @callbacks[eventType]?.each (callback) ->
        callback data

    clear: ->
      @store null, MODES.none

    store: (data, mode) ->
      @mode = mode
      @buffer = data
]