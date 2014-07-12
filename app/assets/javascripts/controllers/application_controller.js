App.ApplicationController = Ember.Controller.extend({
  needs: ["application"],
  closeNotification: function(){
    var notification = this.get('notification');
    if(notification != null) {
      if(notification.persists != null)
        notification.persists = null;
      else
        this.set('notification', null);
    }
  },
  signedInUser: function(){
    if(App.currentUser != undefined)
      return JSON.parse(App.currentUser);
    else
      return null;
  }.property('App.currentUser'),
  // notification alert
  // type can be: error, info, success
  // example: this.get('controllers.application').notify({title: "Error!", message: "An error occurred in foobar.", type: "alert-error"})
  notify: function(options) {
    this.set('notification', options);
  }
});
