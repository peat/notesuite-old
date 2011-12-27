class MasterCatalog < ActiveRecord::Base
  set_primary_key :master_id
  set_table_name :master_catalog

  default_scope order("currency_region, substring(master_code FROM 'P-[A-Za-z]?(\\d+)')::int")

  scope :search, lambda { |value|
    like_str = "'%#{value}%'"
    fields = %w{ master_description master_code currency_unit currency_region overprint_currency_unit overprint_currency_region printer_name printer_region }

    where( fields.collect { |f| "#{f} ilike #{like_str}" }.join(' OR ') )
  }

end
