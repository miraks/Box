angular.module('BoxApp').factory 'AuthorizationError', ['AppError', (AppError) ->
  class AuthorizationError extends AppError
]