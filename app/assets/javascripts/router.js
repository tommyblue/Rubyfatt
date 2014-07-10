App.Router.map(function(){
  this.route('login');
  this.resource('customers', function(){
    this.resource('customer', { path: ':customer_id' });
    this.route('new');
  });
});

// App.Router.reopen({
//   rootURL: '/'
// });

Ember.Route.reopen({
  activate: function(){
    this.controllerFor('application').closeNotification();
    this._super();
  }
});

// Ember.SimpleAuth.AuthenticatedRouteMixin.reopen({
//   error: function(reason, transition) {
//     if (reason.status === 401) {
//       console.log('401!');
//       // this.redirectToLogin(transition);
//     } else {
//       console.log('unknown problem');
//     }
//   }
// });
