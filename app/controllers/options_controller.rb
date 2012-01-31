class OptionsController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
end
