angular.module('BoxApp').service 'AudioPlayer', ['$rootScope', 'Storage', 'UUID', ($rootScope, Storage, UUID) ->
  player = null

  class Track
    constructor: (@name, sources) ->
      @id = UUID.generate()
      @source = @findPlayableSource sources

    equal: (other) ->
      @id == other.id

    findPlayableSource: (sources) ->
      return sources unless Object.isArray sources
      sources.find (source) -> player.playerEl.canPlayType "audio/#{source.split('.').last()}"

  class AudioPlayer
    constructor: ->
      # TODO: move playlist to class
      @playlist = []
      @createDOMElement()
      @bindCallbacks()

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

    playNow: (nameOrTrack, sources) ->
      @currentTrack = @createTrack nameOrTrack, sources
      @addToPlayList @currentTrack unless @isInPlaylist @currentTrack
      @playerEl.src = @currentTrack.source
      @play()
      $rootScope.$emit 'audioplayer.trackchanged', @currentTrack

    addToPlayList: (nameOrTrack, sources) ->
      track = @createTrack nameOrTrack, sources
      @playlist.push track
      $rootScope.$emit 'audioplayer.playlistupdated', @playlist

    removeFromPlayList: (track) ->
      @playlist.remove (tr) -> track.equal tr

    isInPlaylist: (track) ->
      @playlist.any (tr) => track.equal tr

    nextTrack: ->
      index = @playlist.findIndex (track) => @currentTrack.equal track
      @playlist[index + 1]

    switchToNextTrack: =>
      next = @nextTrack()
      return @currentTrack = next unless next?
      @playNow next

    createTrack: (nameOrTrack, sources) ->
      if nameOrTrack.constructor == Track
        nameOrTrack
      else
        new Track nameOrTrack, sources

    createDOMElement: ->
      @playerEl = document.createElement 'audio'

    bindCallbacks: ->
      @bind 'ended', @switchToNextTrack


  player = new AudioPlayer
]