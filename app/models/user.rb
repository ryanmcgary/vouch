class User < ActiveRecord::Base     
  has_many :authentications, :foreign_key => "user_id", :dependent => :destroy
  has_many :recordings
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  def apply_omniauth(omniauth)
    self.profile_pic = omniauth['user_info']['image'] if profile_pic.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])    
  end                                                                                
  
  def password_required?
    (authentications.empty? || !password.blank?) && super    
  end
end
