class Currency < ActiveRecord::Base
  belongs_to :region
  has_many :masters, :dependent => :destroy
  
  belongs_to :authority
  
  validates_presence_of :unit, :region
  validates_uniqueness_of :unit, :scope => [:region_id, :authority_id]

  default_scope includes(:region, :authority).order('regions.name, currencies.name')

  def name
    self.region.name + ' ' + self.unit
  end
  
  def name_for_select( length = 37 )
    out = "#{self.name} - #{self.authority.try(:name)}".strip
    if out.length > length
      out = out[0,length] + ' ...'
    end
    out
  end
  
  def self.for_select
    all.collect { |u| [ u.name_for_select, u.id ] }.sort
  end
  
  def to_param
    "#{self.id}-#{self.name}".gsub(/ /,'-').gsub(/\//, '')
  end
  
end
