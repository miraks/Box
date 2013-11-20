angular.module('BoxApp').factory 'User', ['RailsResource', (RailsResource) ->
  class User extends RailsResource
    @configure
      url: '/api/v1/users'
      name: 'user'
      pluralName: 'users'

    @search = (params) ->
      @$get @$url('search'), query: params
]