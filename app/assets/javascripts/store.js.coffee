App.Store = DS.Store.extend
  # Override the default adapter with the `DS.ActiveModelAdapter` which
  # is built to work nicely with the ActiveModel::Serializers gem.
  # adapter: '_ams'
  adapter: 'DS.RESTAdapter'

DS.RESTAdapter.reopen
  namespace: 'api/v1'
  # headers: {
  #   "API_KEY": "secret key"
  #   "ANOTHER_HEADER": "Some header value"
  # }
