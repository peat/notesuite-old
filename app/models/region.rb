class Region < ActiveRecord::Base

  has_many :currencies, :dependent => :destroy
  has_many :masters, :through => :currencies

  belongs_to :parent, :class_name => "Region"
  has_many :children, :foreign_key => :parent_id, :class_name => "Region"

  has_many :authorities
  
  validates_presence_of :name
  validates_uniqueness_of :name

  before_save :update_ancestry

  default_scope order('regions.ancestry')

  def self.top
    find(94) # Earth
  end

  def self.for_select
    all
      .sort { |a,b| a.ancestry <=> b.ancestry }
      .collect { |u| [ ("&nbsp;&nbsp;" * u.depth ).html_safe + u.name, u.id ] }
  end
  
  def to_param
    "#{self.id}-#{self.name}".gsub(/ /,'-')
  end

  def depth
    ancestry.scan(':').size
  end

  protected

  def update_ancestry
    path = [ self.name ]
    target = self
    while target.parent_id
      target = Region.find( target.parent_id )
      path << target.name
    end
    self[:ancestry] = path.reverse.join(':')
  end

end