class DropArtwork < ActiveRecord::Migration
  def self.up
    drop_table :artworks
    remove_column :notes, :reverse_id
    remove_column :notes, :obverse_id
  end

  def self.down
    # nah.
  end
end
