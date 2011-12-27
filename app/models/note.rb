class Note < ActiveRecord::Base

  belongs_to :master
  has_one :currency, :through => :master

  belongs_to :grade

  validates_presence_of :master
  validates_uniqueness_of :serial, :scope => :master_id, :allow_blank => true

  def to_param
    "#{self.id}-#{self.master.region.name}-#{self.master.code}".gsub(/[ \?]/,'-')
  end

  def sort_key
    "#{master.region.name} #{master.code}"
  end

end
