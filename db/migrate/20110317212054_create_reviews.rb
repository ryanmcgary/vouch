class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.integer :remoteurl_id      
      t.string :name
      t.string :mp3

      t.timestamps
    end    
    add_index :reviews, :remoteurl_id
  end

  def self.down
    remove_index :reviews, :remoteurl_id
    drop_table :reviews
  end
end