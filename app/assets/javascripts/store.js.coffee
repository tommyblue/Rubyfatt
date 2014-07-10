App.ApplicationStore = DS.Store.extend
  adapter: '-active-model'
  # adapter: 'DS.RESTAdapter'

# DS.RESTAdapter.reopen
App.ApplicationAdapter = DS.RESTAdapter.extend
  # Examples from http://andycrum.com/2014/06/02/getting-started-with-ember-data/
  # host: 'http://api.example.com'
  # headers: {
  #   'COOL_HEADER': '1234'
  #   'COOLEST_HEADER': '5678'
  # }
  namespace: 'api/v1'

Ember.SimpleAuth.Authenticators.OAuth2.reopen
  serverTokenEndpoint: '/api/v1/users/sign_in'
