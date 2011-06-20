class Printer < ActiveRecord::Base
  belongs_to :country
  has_many :masters
  validates_presence_of :name, :country

  default_scope order('printers.name')

  def self.for_select
    includes(:country).collect { |p| [ p.name_for_select, p.id] }
  end
  
  def name_for_select
    "#{self.name} (#{self.country.name})"
  end
end
