class Remoteurl < ActiveRecord::Base
  belongs_to :site
  has_many :reviews
  
  before_validation :create_permalink  
  
  def create_permalink
    if self.permalink.blank?
      self.content = self.content.squeeze(' ').strip
      self.permalink = Remoteurl.make_permalink(self.content)
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
  
  def to_param
    permalink
  end         
  
end
