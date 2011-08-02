class LanyardsController < ApplicationController
#  TODO: Before filter to make embed find permalink_URL
  # before_filter :make_permalink, :except => [:show] 
   
  def show
    @site = Site.find_by_permalink(params[:site_id])   

    #@speaker.lanyard_log(request.env["HTTP_REFERER"], params[:v])    

    # /speakers/Scott_Hanselman/badge/embed?v=1
    #render :partial => "embed.js.erb", :content_type => 'application/javascript'
  end

  def embed 
     @remoteurl = Remoteurl.find_by_permalink(params[:remoteurl])  
    
    #@site.(request.env["HTTP_REFERER"], params[:v])    

    # /speakers/Scott_Hanselman/badge/embed?v=1
     render :partial => "embed.js.erb", :content_type => 'application/javascript'
  end
 
end
