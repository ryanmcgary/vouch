class Recording < ActiveRecord::Base
  attr_accessible :audio_file, :remoteurl_id, :call_id, :synopsis, :call_completed 

  belongs_to :remoteurl
  belongs_to :user
end
