class AddSpecimen < ActiveRecord::Migration
  def self.up
    add_column :notes, :specimen, :boolean, :null => false, :default => false
  end

  def self.down
    drop_column :notes, :specimen
  end
end
