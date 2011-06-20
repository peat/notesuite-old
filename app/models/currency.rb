class Currency < ActiveRecord::Base
  belongs_to :country
  has_many :masters, :dependent => :destroy
  
  belongs_to :authority
  
  validates_presence_of :unit, :country
  validates_uniqueness_of :unit, :scope => [:country_id, :authority_id]

  default_scope includes(:country).order('countries.name, currencies.name')

  def name
    self.country.name + ' ' + self.unit
  end
  
  def name_for_select( length = 37 )
    out = "#{self.name} - #{self.authority.try(:name)}".strip
    if out.length > length
      out = out[0,length] + ' ...'
    end
    out
  end
  
  def self.for_select
    includes(:authority).collect { |u| [ u.name_for_select, u.id ] }.sort
  end
  
  def to_param
    "#{self.id}-#{self.name}".gsub(/ /,'-')
  end
  
end
