class Note < ActiveRecord::Base

  belongs_to :master
  has_one :currency, :through => :master

  belongs_to :grade

  validates_presence_of :master
  validates_uniqueness_of :serial, :scope => :master_id, :allow_blank => true

  named_scope :search, lambda { |value|
    fields = ['notes.serial', 'notes.description', 'grades.name', 'masters.code', 'cast(masters.denomination as varchar)', 'masters.description', 'currencies.unit', 'regions.name', 'authorities.name']
    condition_string = fields.collect { |f| "lower(#{f}) like lower(?)"}.join(" OR ")
    condition_values = fields.collect { |f| "%#{value}%" } # stack up one value per field
    {
      # masters, currencies, regions already in default_scope
      :joins => [
          'INNER JOIN grades ON grades.id=notes.grade_id',
          'INNER JOIN authorities ON authorities.id=currencies.authority_id'
        ],
      :conditions => [condition_string, condition_values].flatten
    }
  }
  
  def to_param
    "#{self.id}-#{self.master.region.name}-#{self.master.code}".gsub(/[ \?]/,'-')
  end

  def sort_key
    "#{master.region.name} #{master.code}"
  end

end
