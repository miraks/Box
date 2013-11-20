angular.module('BoxApp').factory 'InternalError', ['AppError', (AppError) ->
  class InternalError extends AppError
    message: ->
      @data
]