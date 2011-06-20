class Note < ActiveRecord::Base

  belongs_to :master
  has_one :currency, :through => :master
  has_one :country, :through => :currency
  
  belongs_to :grade

  validates_presence_of :master
  validates_uniqueness_of :serial, :scope => :master_id, :allow_blank => true
  
  attr_accessor :obverse_file, :reverse_file
  
  after_save :update_images

  named_scope :search, lambda { |value|
    fields = ['notes.serial', 'notes.description', 'grades.name', 'masters.code', 'cast(masters.denomination as varchar)', 'masters.description', 'currencies.unit', 'countries.name', 'authorities.name']
    condition_string = fields.collect { |f| "lower(#{f}) like lower(?)"}.join(" OR ")
    condition_values = fields.collect { |f| "%#{value}%" } # stack up one value per field
    {
      # masters, currencies, countries already in default_scope
      :joins => [
          'INNER JOIN grades ON grades.id=notes.grade_id',
          'INNER JOIN authorities ON authorities.id=currencies.authority_id'
        ],
      :conditions => [condition_string, condition_values].flatten
    }
  }
  
  def to_param
    "#{self.id}-#{self.master.country.name}-#{self.master.code}".gsub(/[ \?]/,'-')
  end

end
