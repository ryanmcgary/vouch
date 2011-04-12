class ApplicationController < ActionController::Base
  protect_from_forgery #:only => [:destroy]   

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
    
    def set_access_control_headers
     headers['Access-Control-Allow-Origin'] = '*'
     headers['Access-Control-Request-Method'] = '*'
    end 
    
    private
      
      def after_sign_out_path_for(resource) 
        if params[:layout] == "embed"
          "/authentications/force" 
        else
          super
        end
      end
end
