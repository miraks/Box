angular.module('BoxApp').service 'AudioPlayer', ['$rootScope', '$timeout', 'Storage', 'UUID', ($rootScope, $timeout, Storage, UUID) ->
  player = null

  class Track
    constructor: (@name, sources) ->
      @id = UUID.generate()
      @source = @findPlayableSource sources
      # hack for chrome
      $timeout @loadDuration, 10

    equal: (other) ->
      @id == other.id

    findPlayableSource: (sources) ->
      return sources unless Object.isArray sources
      sources.find (source) -> player.playerEl.canPlayType "audio/#{source.split('.').last()}"

    loadDuration: =>
      audio = if @equal player.currentTrack
        player.playerEl
      else
        audioEl = document.createElement 'audio'
        audioEl.preload = 'metadata'
        audioEl.src = @source
        audioEl
      audio.addEventListener 'loadedmetadata', =>
        @duration = audio.duration

  class AudioPlayer
    constructor: ->
      # TODO: move playlist to class
      @playlist = []
      @playerEl = document.createElement 'audio'
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
      if nameOrTrack?
        @currentTrack = @createTrack nameOrTrack, sources
        @addToPlaylist @currentTrack unless @isInPlaylist @currentTrack
        @playerEl.src = @currentTrack.source
        @play()
      else
        @currentTrack = null
        @playerEl.src = null
        @stop()
      $rootScope.$emit 'audioplayer.trackchanged', @currentTrack

    addToPlaylist: (nameOrTrack, sources) ->
      track = @createTrack nameOrTrack, sources
      @playlist.push track
      $rootScope.$emit 'audioplayer.playlistupdated', @playlist

    removeFromPlaylist: (track) ->
      @playlist.remove (tr) -> track.equal tr

    isInPlaylist: (track) ->
      @playlist.any (tr) => track.equal tr

    currentTrackIndex: ->
      return unless @currentTrack
      @playlist.findIndex (track) => @currentTrack.equal(track)

    prevTrack: ->
      index = @currentTrackIndex()
      index = if index? then index - 1 else @playlist.length - 1
      @playlist[index]

    nextTrack: ->
      index = @currentTrackIndex()
      index = if index? then index + 1 else 0
      @playlist[index]

    switchToPrevTrack: ->
      @playNow @prevTrack()

    switchToNextTrack: ->
      @playNow @nextTrack()

    createTrack: (nameOrTrack, sources) ->
      if nameOrTrack.constructor == Track
        nameOrTrack
      else
        new Track nameOrTrack, sources

    bindCallbacks: ->
      @bind 'ended', => @switchToNextTrack()


  player = new AudioPlayer
]