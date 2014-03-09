# For more information see: http://emberjs.com/guides/routing/

App.Router.map ()->
  @resource 'customers', ->
    @route 'new'
    @route 'edit'
  @resource 'customer', { path: '/customer/:customer_id' }
