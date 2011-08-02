#  profile_pic, phone_number, company, title, description, location, email
class User < ActiveRecord::Base     
  has_many :authentications, :foreign_key => "user_id", :dependent => :destroy
  has_many :recordings
  has_many :sites
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :phone_number, :remember_me, 
                  :title, :company, :description, :location, :full_name

  validates_presence_of :company, :on => :save, :message => "can't be blank"
  validates_presence_of :title, :on => :save, :message => "can't be blank"
  validates_presence_of :full_name, :on => :save, :message => "can't be blank"
  validates_presence_of :phone_number, :on => :save, :message => "can't be blank"
  validates_length_of :phone_number, :within => 10..10, :on => :save, :message => "must be 10 digits"
  validates_format_of :phone_number, :with => /^[\d]+$/, :on => :save, :message => "must be digits only"                  



  
  def apply_omniauth(omniauth)
    self.profile_pic = omniauth['user_info']['image'] if profile_pic.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])    
  end                                                                                
  
  def password_required?
    (authentications.empty? || !password.blank?) && super    
  end
    
end
