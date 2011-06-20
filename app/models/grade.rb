class Grade < ActiveRecord::Base
  has_many :notes
  
  validates_presence_of :name, :full_name

  default_scope order('grades.rank')

  def self.for_select
    self.find(:all).collect { |u| [ u.name, u.id ] }
  end
  
  def to_param
    "#{self.id}-#{self.name}"
  end
  
end
