angular.module('BoxApp').service 'CurrentUser', ['User', (User) ->
  class CurrentUser extends User
    constructor: ->
      currentUserElement = document.getElementById('current_user_data')
      data = JSON.parse currentUserElement.innerHTML
      super data.user

    isLoggedIn: ->
      @id?

    isSelf: (user) ->
      @isLoggedIn() and @id == user.id

  new CurrentUser
]