class SlipsController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
end
