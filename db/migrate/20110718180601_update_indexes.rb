class UpdateIndexes < ActiveRecord::Migration
  def self.up
    add_index :regions, :parent_id
    add_index :currencies, :unit
    add_index :grades, :rank
    add_index :masters, :code
    add_index :masters, :printer_id
    add_index :notes, :serial
    add_index :printers, :region_id
  end

  def self.down
    remove_index :regions, :parent_id
    remove_index :printers, :region_id
    remove_index :notes, :serial
    remove_index :masters, :printer_id
    remove_index :masters, :code
    remove_index :grades, :rank
    remove_index :currencies, :unit
    remove_index :regions, :parent_id
  end
end