App.Store = DS.Store.extend
  adapter: '-active-model'
  # adapter: 'DS.RESTAdapter'

# DS.RESTAdapter.reopen
App.ApplicationAdapter = DS.RESTAdapter.extend
  namespace: 'api/v1'

Ember.SimpleAuth.Authenticators.OAuth2.reopen
  serverTokenEndpoint: '/api/v1/users/sign_in'
