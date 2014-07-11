App.ApplicationRoute = Ember.Route.extend Ember.SimpleAuth.ApplicationRouteMixin,
  actions:
    sessionAuthenticationSucceeded: ->
      store = @store
      Ember.$.ajax
        url: '/api/v1/users/profile'
        data: {}
        success: (results) ->
          localStorage['currentUser'] = JSON.stringify(results.user)
          localStorage['currentUserId'] = results.user.id
          user = store.createRecord('user', results.user)
          App.set('currentUser', user)

      # @get("controllers.application").notify
      #   message: "You are now signed in",
      #   type: "success",
      #   persists: false
      @_super()

    sessionAuthenticationFailed: (error) ->
      msg = JSON.parse(error).error
      @get("controllers.application").notify
        message: msg,
        type: "alert",
        persists: false

    sessionInvalidationSucceeded: ->
      localStorage.removeItem('currentUser')
      App.set('currentUser', null)

  redirect: ->
    @transitionTo 'index'
