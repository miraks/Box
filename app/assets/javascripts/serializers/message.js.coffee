angular.module('rails').factory 'MessageSerializer', ['railsSerializer', (railsSerializer) ->
  railsSerializer ->
    @exclude 'user'
    @resource 'user', 'User'
    @add 'userId', (message) -> message.user.id
]