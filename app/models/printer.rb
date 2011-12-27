class Printer < ActiveRecord::Base
  belongs_to :region
  has_many :masters, :class_name => 'MasterCatalog', :foreign_key => 'printer_id'
  validates_presence_of :name, :region

  default_scope order('printers.name')

  def self.for_select
    includes(:region).collect { |p| [ p.name_for_select, p.id] }
  end
  
  def name_for_select
    "#{self.name} (#{self.region.name})"
  end
end
