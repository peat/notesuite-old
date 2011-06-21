class AddAncestryToRegions < ActiveRecord::Migration
  def self.up
    add_column :regions, :ancestry, :string
    add_index :regions, :ancestry
  end

  def self.down
    remove_index :regions, :ancestry
    remove_column :regions, :ancestry
  end
end
