class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :create, :destroy, :force]   
  # GET /authentications
  # GET /authentications.xml
  def index
    @authentications = current_user.authentications if current_user

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @authentications }
    end
  end

  # POST /authentications
  # POST /authentications.xml
  def create                        
    # render :text => request.env["omniauth.auth"].to_yaml
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user  # if user logged in but doesn't have this auth in DB
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else # if user doesn't exist
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save #if validation passes
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else #if validation doesn't pass
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end  
  end

  # DELETE /authentications/1
  # DELETE /authentications/1.xml
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy

    respond_to do |format|
      format.html { redirect_to(authentications_url) }
      format.xml  { head :ok }
    end
  end
  
  def closewindow
    
  end
  def force

  end
  
  protected 
    def authenticate_user_on_steroids! 
        unless user_signed_in? 
            redirect_to new_user_session_path(:layout => 'embed') 
        end 
    end  
end
