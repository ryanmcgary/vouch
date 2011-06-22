class AddCompanyTitleEtcToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :company, :string
    add_column :users, :title, :string
    add_column :users, :description, :string
    add_column :users, :location, :string
  end

  def self.down
    remove_column :users, :location
    remove_column :users, :description
    remove_column :users, :title
    remove_column :users, :company
  end
end
