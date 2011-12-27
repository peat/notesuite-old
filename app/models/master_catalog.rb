class MasterCatalog < ActiveRecord::Base
  set_primary_key :master_id
  set_table_name :master_catalog

  default_scope order('currency_region, master_code')
end
