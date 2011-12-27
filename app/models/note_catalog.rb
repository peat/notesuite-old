class NoteCatalog < ActiveRecord::Base
  set_primary_key :note_id
  set_table_name :note_catalog

  default_scope order("currency_region, substring( master_code FROM 'P-[A-Za-z]?(\\d+)')::int")

  scope :search, lambda { |value|
    like_str = "'%#{value}%'"
    fields = %w{ note_serial note_description master_description master_code currency_unit currency_region grade_name overprint_currency_unit overprint_currency_region printer_name printer_region }

    where( fields.collect { |f| "#{f} ilike #{like_str}" }.join(' OR ') )
  }
  
end
