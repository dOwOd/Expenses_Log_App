class HowtouseController < ApplicationController
  skip_before_action :login_required
  skip_before_action :join_required
  
  def index
  end
end
