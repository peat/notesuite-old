class AddRegions < ActiveRecord::Migration
  def self.up
    rename_table :countries, :regions
    add_column :regions, :parent_id, :integer

    [:authorities, :currencies, :printers].each do |t|
      rename_column t, :country_id, :region_id
    end
  end

  def self.down
    rename_table :regions, :countries
    remove_column :countries, :parent_id, :integer

    [:authorities, :currencies, :printers].each do |t|
      rename_column t, :region_id, :country_id
    end
  end
end
