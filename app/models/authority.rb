class Authority < ActiveRecord::Base

  belongs_to :country
  has_many :currencies
  has_many :masters, :through => :currencies
  
  validates_presence_of :name, :country
  validates_uniqueness_of :name, :scope => :country_id

  default_scope includes(:country).order('countries.name, authorities.name')

  def self.for_select
    self.find(:all, :include => [:country] ).collect { |a| [ a.name_for_select, a.id ] }
  end
  
  def name_for_select( length = 37 )
    out = "#{self.country.try(:name)} - #{self.name}".strip
    if out.length > length
      out = out[0,length] + ' ...'
    end
    out
  end

  def to_param
    "#{self.id}-#{self.country.name}-#{self.name}".gsub(/[^0-9a-zA-Z]/,'-')
  end

end
