class CreateRecordings < ActiveRecord::Migration
  def self.up
    create_table :recordings do |t|
      t.string :audio_file
      t.string :call_id
      t.string :synopsis
      t.string :transcription
      t.boolean :call_completed
      t.references :remoteurl
      t.references :user

      t.timestamps
    end
  end

  def self.down
    remove_index :recordings, :column_name
    drop_table :recordings
  end
end