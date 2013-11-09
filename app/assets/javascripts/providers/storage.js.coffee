angular.module('BoxApp').provider 'Storage', [ ->
  storage = window.box.storage ||= {}

  @storage = (newStorage) ->
    storage = newStorage

  class Storage
    @$get = ->
      new @ storage

    constructor: (@storage) ->

    get: (name, def) ->
      @storeDefault name, def if def?
      @storage[name]

    store: (name, value) ->
      @storage[name] = value

    storeDefault: (name, value) ->
      @storage[name] ||= value

    has: (name) ->
      Object.has @storage, name

    remove: (name) ->
      delete @storage[name]
]