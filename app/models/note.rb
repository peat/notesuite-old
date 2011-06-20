class Note < ActiveRecord::Base

  belongs_to :master
  has_one :currency, :through => :master
  
  belongs_to :grade
  belongs_to :obverse, :class_name => 'Artwork'
  belongs_to :reverse, :class_name => 'Artwork'
  
  validates_presence_of :master
  validates_uniqueness_of :serial, :scope => :master_id, :allow_blank => true
  
  attr_accessor :obverse_file, :reverse_file
  
  after_save :update_images

  default_scope :joins => 'INNER JOIN masters ON masters.id=notes.master_id INNER JOIN currencies ON currencies.id=masters.currency_id INNER JOIN countries ON countries.id=currencies.country_id', :order => 'countries.name, masters.issued_on, currencies.unit, masters.denomination'
  
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
  
  def obverse=( file )
    self.obverse.destroy if self.obverse
    self.obverse_file = file
    self.obverse_id = Artwork.create( :source_file => file, :basename => 'tmp-obverse' ).id
  end

  # see obverse= for notes
  def reverse=( file )
    self.reverse.destroy if self.reverse
    self.reverse_file = file
    self.reverse_id = Artwork.create( :source_file => file, :basename => 'tmp-reverse' ).id
  end

  def to_param
    "#{self.id}-#{self.master.country.name}-#{self.master.code}".gsub(/[ \?]/,'-')
  end
  
  protected
  
  def update_images
    if self.obverse_file
      self.obverse.update_attributes( :basename => "#{self.to_param}-obverse", :source_file => self.obverse_file )
      self.obverse.transform_and_archive
    end
    
    if self.reverse_file
      self.reverse.update_attributes( :basename => "#{self.to_param}-reverse", :source_file => self.reverse_file )
      self.reverse.transform_and_archive
    end
  end

end
