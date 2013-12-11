angular.module('BoxApp').service 'AudioPlayer', ['$rootScope', 'Storage', 'UUID', ($rootScope, Storage, UUID) ->
  player = null

  class Track
    constructor: (@name, sources) ->
      @id = UUID.generate()
      @source = @findPlayableSource sources
      @loadDuration()

    equal: (other) ->
      @id == other.id

    findPlayableSource: (sources) ->
      return sources unless Object.isArray sources
      sources.find (source) -> player.playerEl.canPlayType "audio/#{source.split('.').last()}"

    loadDuration: ->
      audio = document.createElement 'audio'
      audio.preload = 'metadata'
      audio.src = @source
      audio.addEventListener 'loadedmetadata', =>
        @duration = audio.duration

  class AudioPlayer
    constructor: ->
      # TODO: move playlist to class
      @playlist = []
      @playerEl = document.createElement 'audio'
      @playerEl.preload = 'none'
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