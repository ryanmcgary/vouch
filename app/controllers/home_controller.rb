class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to dashboard_install_path   
    end
  end

end
