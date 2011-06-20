class Authority < ActiveRecord::Base

  belongs_to :region
  has_many :currencies
  has_many :masters, :through => :currencies
  
  validates_presence_of :name, :region
  validates_uniqueness_of :name, :scope => :region_id

  default_scope includes(:region).order('regions.name, authorities.name')

  def self.for_select
    all.collect { |a| [ a.name_for_select, a.id ] }
  end
  
  def name_for_select( length = 37 )
    out = "#{self.region.try(:name)} - #{self.name}".strip
    if out.length > length
      out = out[0,length] + ' ...'
    end
    out
  end

  def to_param
    "#{self.id}-#{self.region.name}-#{self.name}".gsub(/[^0-9a-zA-Z]/,'-')
  end

end
