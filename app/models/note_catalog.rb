class NoteCatalog < ActiveRecord::Base
  set_primary_key :note_id
  set_table_name :note_catalog

  default_scope order("currency_region, substring( master_code FROM 'P-[A-Za-z]?(\\d+)')::int")
end
