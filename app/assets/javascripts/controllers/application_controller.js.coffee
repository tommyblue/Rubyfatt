App.ApplicationController = Ember.Controller.extend
  # close notification alert
  # bind to action in template, example: {{action "closeNotification"}}
  # detects if persists and closes on next transition
  closeNotification: ->
    notification = @get('notification')
    if notification
      if notification.persists
        notification.persists = null
      else
        @set('notification', null)

  signedInUser: (->
    if localStorage['currentUser']
      return @store.find('user', localStorage['currentUser'].id)
    else
      return null
  ).property('App.currentUser')

  # notification alert
  # type can be: error, info, success
  # example: @get('controllers.application').notify({title: "Error!", message: "An error occurred in foobar.", type: "alert-error"})
  notify: (options) ->
    @set('notification', options)
