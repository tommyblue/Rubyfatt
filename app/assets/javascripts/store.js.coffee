App.Store = DS.Store.extend
  # Override the default adapter with the `DS.ActiveModelAdapter` which
  # is built to work nicely with the ActiveModel::Serializers gem.
  # adapter: '_ams'
  adapter: 'DS.RESTAdapter'

DS.RESTAdapter.reopen
  namespace: 'api/v1'
# DS.ActiveModelAdapter.reopen
#   namespace: 'api/v1'

Ember.SimpleAuth.Authenticators.OAuth2.reopen
  serverTokenEndpoint: '/api/v1/users/sign_in'
