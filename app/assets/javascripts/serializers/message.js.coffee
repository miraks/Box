angular.module('rails').factory 'MessageSerializer', ['railsSerializer', (railsSerializer) ->
  railsSerializer ->
    @exclude 'user', 'recipient'
    @resource 'user', 'User'
    @resource 'recipient', 'User'
    @add 'userId', (message) -> message.user.id
]