# For more information see: http://emberjs.com/guides/routing/

App.Router.map ()->
  @route 'login'
  @resource 'customers', ->
    @route 'new'
    @route 'edit'
  @resource 'customer', { path: '/customer/:customer_id' }
