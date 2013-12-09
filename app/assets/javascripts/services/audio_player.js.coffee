angular.module('BoxApp').service 'AudioPlayer', ['$rootScope', 'Storage', ($rootScope, Storage) ->
  class AudioPlayer
    constructor: ->
      @createDOMElement()

    ['play', 'pause', 'load'].each (method) =>
      @::[method] = ->
        @playerEl[method]()

    ['currentSrc', 'currentTime', 'duration', 'ended', 'error',
     'loop', 'muted', 'paused', 'played', 'readyState',
     'seekable', 'seeking', 'volume'].each (method) =>
      @::[method] = (value) ->
        return @playerEl[method] if arguments.length == 0
        @playerEl[method] = value

    bind: (eventName, callback) ->
      @playerEl.addEventListener eventName, callback

    playToggle: ->
      if @paused() then @play() else @pause()

    volumeToggle: ->
      @muted !@muted()

    stop: ->
      @pause()
      @currentTime 0

    progressPercent: ->
      progress = @currentTime() / @duration() * 100
      if isNaN(progress) then 0 else progress

    volumePercent: ->
      @volume() * 100

    setSrc: (sources) ->
      @src = sources.find (source) => @playerEl.canPlayType "audio/#{source.split('.').last()}"
      @playerEl.src = @src
      $rootScope.$emit 'audioplayer.sourceschanged', @src

    createDOMElement: ->
      @playerEl = document.createElement 'audio'

  new AudioPlayer
]