require "twiliolib.rb"

# @start snippet
# your Twilio authentication credentials
ACCOUNT_SID = 'AC3428bd048e76d94c7c325980115bbcc9'
ACCOUNT_TOKEN = '64e5c64955c6b9e1d68f0a9f58b0944b'

# version of the Twilio REST API to use
API_VERSION = '2010-04-01'

# base URL of this application
BASE_URL = "http://growing-mist-751.heroku.com/recordings"  # "http://localhost:3000/recordings"  

# Outgoing Caller ID you have previously validated with Twilio
CALLER_ID = '6158525397'   

class RecordingsController < ApplicationController
    before_filter :authenticate_user!, :except => [:show, :index, :trunk, :record, :editrecording, :hangup, :destroy]  
    before_filter :authorized_user, :only => :destroy  
    respond_to :html, :xml  
    
    def create
      @recording = current_user.recordings.build(params[:recording])
             if @recording.save
               flash[:success] = "Recording created!"
               redirect_to root_path
             else 
               render 'root'
             end             
    end
    
    def destroy
      @recording.destroy
      redirect_to :controller => "users", :action => "show", :id => @recording.user.id   
    end
    
    def show
      @recording = Recording.find(params[:id])  
      @title = ( "View " + @recording.user.name.pluralize + " Recording" )
     
      
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @recording }
      end
    end
    
    def makecall  #New
    
      # parameters sent to Twilio REST API
      d = {
          'From' => CALLER_ID,
          'To' => current_user[:phone_number],
          'Url' => BASE_URL + '/trunk.xml',
          'Timeout' => '15',
      }              
    
      #begin
      account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
                  resp = account.request(
                      "/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/Calls",
                      'POST', d)      
                  resp.error! unless resp.kind_of? Net::HTTPSuccess               
      
      # save initial form and callid to database
      resp = Hash.from_xml(resp.body)
      resp2 = resp['TwilioResponse']['Call']['Sid'] # "324234wer" 
      ourform = { :call_id => resp2 }                         
      @recording = current_user.recordings.build(params[:recording])
      @recording[:call_id] = resp2
      if @recording.save             
        flash[:success] = "Calling #{ current_user.phone_number }... "
        redirect_to root_path
      end
    end
    
    def trunk
      @record = BASE_URL + '/record.xml'  ##Sets GOTO url when there is a timeout from silence 
      @trunk = BASE_URL + '/trunk.xml' #Sets GOTO url when there is a timeout from silence 
      
      respond_to do |format|
        format.xml { @record }
      end

      # detects if recordingurl passed, updates if yes
      if params[:RecordingUrl] != nil then  
        @phonecall = Recording.where(:call_id => params[:CallSid]).first
        @phonecall.update_attributes(:audio_file => params[:RecordingUrl]) 
        redirect_to :action => "editrecording" 
      end                    
    end
    
    def record            
      @trunk = BASE_URL + '/trunk.xml' #Sets POST url when recording is done 
      @record = BASE_URL + '/record.xml' #Sets GOTO url when there is a timeout from silence  
      
      if params['Digits'] == '9'
          redirect_to :action => 'hangup'
          return
      end
      
      respond_to do |format|
          format.xml { @trunk }
      end            
    end

    def editrecording
      @editrecording = BASE_URL + '/editrecording.xml' #Sets GOTO url when there is a timeout from silence     
      @record = BASE_URL + '/record.xml' #Sets GOTO url to re-record 
      @recordingurl = Recording.where(:call_id => params[:CallSid]).first.audio_file #Finds new recording and sends it to xml for playback

      if params[:CallStatus] == "completed" then  
        @phonecall = Recording.where(:call_id => params[:CallSid]).first
        @phonecall.update_attributes(:callcompleted => '1') 
        redirect_to :action => "editrecording"
      end
      
      respond_to do |format|
        format.xml { @editrecording }
      end     
    end
    
    def hangup
      respond_to do |format|
        format.xml { render :action => "hangup.xml.builder", :layout => false } 
      end
    end

    private

      def authorized_user
        @recording = Recording.find(params[:id])
        redirect_to root_path unless current_user == (@recording.user)      
      end
     
end
