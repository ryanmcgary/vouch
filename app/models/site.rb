class Site < ActiveRecord::Base   
  has_many :remoteurls
  before_validation :create_permalink
  #after_save :rebuild_routes
  #after_destroy :rebuild_routes
  
  validates :url,       :presence     => true,
                        :length       => { :maximum  => 50 }
                                              
  def create_permalink
    if self.permalink.blank?
      self.url = self.url.squeeze(' ').strip
      self.permalink = Site.make_permalink(self.url)
    end
  end

  def self.make_permalink(result)
    res = result
    res = res.gsub(/&(\d)+;/, '') # Ditch Entities
    res = res.gsub('&', 'and')    # Replace & with 'and'
    res = res.gsub(/["]/, '')    # replace quotes by nothing
#    res = res.gsub(/[^a-zA-Z\.\-\'|\s]/,'')
    res = res.gsub(/\ +/, '_')    # replace all white space sections with a dash
    res = res.gsub("/", '_')    # replace slashes with dashes
    res = res.gsub(/(_)$/, '')    # trim dashes
    res = res.gsub(/^(_)/, '')    # trim dashes
    res = res.gsub('.','')        # remove periods
    res = res.gsub(',','')        # remove commas
    return res
  end
  def rebuild_routes
    Vouch::Application.reload_routes!
  end                                          
end
