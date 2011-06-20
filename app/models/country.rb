class Country < ActiveRecord::Base
  
  has_many :currencies, :dependent => :destroy
  has_many :masters, :through => :currencies
  
  has_many :authorities
  
  validates_presence_of :name
  validates_uniqueness_of :name

  default_scope order('countries.name')

  def self.for_select
    all.collect { |u| [ u.name, u.id ] }
  end
  
  def to_param
    "#{self.id}-#{self.name}".gsub(/ /,'-')
  end
  
end
