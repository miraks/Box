angular.module('BoxApp').service 'UUID', [ ->
  symbols = [Number.range(0, 9), String.range('a', 'f')].map('every').flatten().map('toString')
  dashPosition = [7, 11, 15, 19]

  generate: ->
    result = []
    32.times (index) ->
      result.push symbols.sample()
      result.push '-' if dashPosition.indexOf(index) >= 0
    result.join ''

  empty: ->
    '00000000-0000-0000-0000-000000000000'
]