class HomeController < ApplicationController

  skip_before_filter :authenticate_user!

  def index
    @locations = Location.all    
  end

end
