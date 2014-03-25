App.Store = DS.Store.extend
  # adapter: '-active-model'
  adapter: 'DS.RESTAdapter'

# App.ApplicationAdapter = DS.RESTAdapter.extend
DS.RESTAdapter.reopen
  namespace: 'api/v1'

Ember.SimpleAuth.Authenticators.OAuth2.reopen
  serverTokenEndpoint: '/api/v1/users/sign_in'
