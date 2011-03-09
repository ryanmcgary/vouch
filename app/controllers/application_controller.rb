class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :layout_by_resource
    
    def layout_by_resource
      if params[:layout] == "embed"
        @application_layout = "application_embed"   
      elsif devise_controller?
        @application_layout = "application_embed"
      else 
        "application"
      end
    end
end
