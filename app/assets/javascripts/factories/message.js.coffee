angular.module('BoxApp').factory 'Message', ['RailsResource', (RailsResource) ->
  class Message extends RailsResource
    @configure
      url: '/api/v1/users/{{user.id}}/messages/{{id}}'
      name: 'message'
      pluralName: 'messages'
      serializer: 'MessageSerializer'

    other: (user) ->
      if @user.id == user.id then @recipient else @user

    equal: (other) ->
      @id? and other.id? and @id == other.id
]