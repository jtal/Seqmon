class CreateFlowcellSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :flowcell_subscriptions do |t|
      t.string :flowcell_id
      t.integer :device_id

      t.timestamps
    end
  end

  def self.down
    drop_table :flowcell_subscriptions
  end
end
