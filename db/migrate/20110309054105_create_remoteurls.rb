class CreateRemoteurls < ActiveRecord::Migration
  def self.up
    create_table :remoteurls do |t|
      t.integer :site_id
      t.string :content

      t.timestamps
    end 
    add_index :remoteurls, :site_id
  end

  def self.down
    remove_index :remoteurls, :site_id
    drop_table :remoteurls
  end
end