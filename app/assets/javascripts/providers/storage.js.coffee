angular.module('BoxApp').provider 'Storage', [ ->
  storage = window.box.storage ||= {}

  @storage = (newStorage) ->
    storage = newStorage

  class Storage
    constructor: (@storage) ->
      @storage ||= {}

    get: (name, def) ->
      @storeDefault name, def if def?
      @storage[name]

    store: (name, value) ->
      @storage[name] = value

    storeDefault: (name, value) ->
      @storage[name] ||= value

    has: (name) ->
      @storage.hasOwnProperty name

    remove: (name) ->
      delete @storage[name]

  @$get = ->
    new Storage storage
]