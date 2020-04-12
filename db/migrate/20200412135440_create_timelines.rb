class CreateTimelines < ActiveRecord::Migration[6.0]
  def change
    create_table :timelines do |t|
      t.integer :user_id
      t.timestamps
    end
  end
end
