class Master < ActiveRecord::Base

  belongs_to :currency
  belongs_to :printer
  has_one :country, :through => :currency
  has_one :authority, :through => :currency
  
  belongs_to :overprint_currency, :class_name => 'Currency'
  has_one :overprint_country, :through => :overprint_currency, :source => :country
  
  has_many :notes, :dependent => :destroy
  
  validates_presence_of :currency
  validates_uniqueness_of :code, :scope => :currency_id, :allow_blank => true
  validates_uniqueness_of :currency_id, :scope => [:denomination, :issued_on, :overprint_currency_id, :code]
  
  default_scope :joins => [
      'INNER JOIN "currencies" ON "masters".currency_id = "currencies".id',
      'INNER JOIN "countries" ON countries.id=currencies.country_id'
    ], :order => 'countries.name, SUBSTRING(masters.code FROM \'[0-9]{1,3}\')::INT, masters.issued_on, masters.denomination'
  
  named_scope :search, lambda { |value|
    fields = ['masters.code', 'cast(masters.denomination as varchar)', 'masters.description', 'currencies.unit', 'countries.name', 'authorities.name', 'printers.name']
    condition_string = fields.collect { |f| "lower(#{f}) like lower(?)"}.join(" OR ")
    condition_values = fields.collect { |f| "%#{value}%" } # stack up one value per field
    {
      :joins => [
          'LEFT JOIN "printers" ON "masters".printer_id = "printers".id',
          'INNER JOIN "currencies" ON "masters".currency_id = "currencies".id',
          'INNER JOIN "countries" ON countries.id=currencies.country_id',
          'INNER JOIN authorities ON authorities.id=currencies.authority_id'
        ],
      :conditions => [condition_string, condition_values].flatten
    }
  }
  
  def self.for_select
    self.find(:all, :include => [:country, :authority, :currency]).collect { |u| [ u.name_for_select, u.id ] }.sort
  end
  
  def name_for_select
    self.code.blank? ? self.name : self.name + " (#{self.code})"
  end

  def name
    "#{self.country.name} #{self.denomination} #{self.currency.unit}"
  end
  
  def denomination=( value ); self[:denomination] = clean_denomination( value ); end
  def denomination; clean_decimal( self[:denomination] ); end
  
  def overprint_denomination=( value ); self[:overprint_denomination] = clean_denomination( value ); end
  def overprint_denomination; clean_decimal( self[:overprint_denomination] ); end

  def overprint
    return nil if self.overprint_denomination.blank? or self.overprint_currency.blank?
    unit = (self.overprint_denomination > 1) ? self.overprint_currency.unit.pluralize : self.overprint_currency.unit
    out = "#{self.overprint_country.name} #{self.overprint_denomination} #{unit}"
    out
  end
  
  def to_param
    "#{self.id}-#{self.country.name}-#{self.code}".gsub(/[ \?]/,'-')
  end
  
  def obverse
    notes.find( :first, :conditions => "obverse_id > 0").try(:obverse)
  end
  
  def reverse
    notes.find( :first, :conditions => "reverse_id > 0").try(:reverse)
  end
  
  protected
  
  def clean_decimal( value )
    return nil unless value
    (value.frac > 0) ? value : value.to_i    
  end

  def clean_denomination( value )
    return BigDecimal( value.to_s.gsub(',','') )
  end
  
end