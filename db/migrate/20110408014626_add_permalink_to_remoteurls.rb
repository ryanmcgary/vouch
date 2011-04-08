class AddPermalinkToRemoteurls < ActiveRecord::Migration
  def self.up
    add_column :remoteurls, :permalink, :string
  end

  def self.down
    remove_column :remoteurls, :permalink
  end
end