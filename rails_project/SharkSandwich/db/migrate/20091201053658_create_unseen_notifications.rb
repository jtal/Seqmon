class CreateUnseenNotifications < ActiveRecord::Migration
  def self.up
    create_table :unseen_notifications do |t|
      t.integer :device_id
      t.string :flowcell_id

      t.timestamps
    end
  end

  def self.down
    drop_table :unseen_notifications
  end
end
