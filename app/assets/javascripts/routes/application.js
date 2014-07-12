App.ApplicationRoute = Ember.Route.extend(Ember.SimpleAuth.ApplicationRouteMixin, {
  needs: ["application"],

  actions: {
    sessionAuthenticationSucceeded: function() {
      var store = this.store;
      Ember.$.ajax({
        url: '/api/v1/users/profile',
        data: {},
        success: function(results) {
          localStorage['currentUser'] = JSON.stringify(results.user);
          localStorage['currentUserId'] = results.user.id;
          // debugger
          // user = store.createRecord('user', results.user)
          App.set('currentUser', localStorage['currentUser'])
        }
      });
      // @get("controllers.application").notify
      //   message: "You are now signed in",
      //   type: "success",
      //   persists: false
      return this._super();
    },
    sessionAuthenticationFailed: function(error) {
      var msg = JSON.parse(error).error;
      this.get("controllers.application").notify({
        message: msg,
        type: "alert",
        persists: false
      });
    },
    sessionInvalidationSucceeded: function() {
      localStorage.removeItem('currentUser');
      localStorage.removeItem('currentUserId');
      // App.set('currentUser', null);
      return this._super();
    }
  },
  redirect: function() {
    return this.transitionTo('index');
  }
});
