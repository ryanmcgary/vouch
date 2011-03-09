class LanyardsController < ApplicationController

  def show
    @site = Site.find(params[:site_id])   

    #@speaker.lanyard_log(request.env["HTTP_REFERER"], params[:v])    

    # /speakers/Scott_Hanselman/badge/embed?v=1
    #render :partial => "embed.js.erb", :content_type => 'application/javascript'
  end

  def embed
    @site = Site.find(params[:site_id])  
 
    #@site.(request.env["HTTP_REFERER"], params[:v])    

    # /speakers/Scott_Hanselman/badge/embed?v=1
    render :partial => "embed.js.erb", :content_type => 'application/javascript'
  end       

end
