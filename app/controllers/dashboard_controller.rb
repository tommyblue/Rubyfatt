class DashboardController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def index
    
  end
end
