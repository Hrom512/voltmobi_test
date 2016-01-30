class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id, index: true
      t.string  :name, null: false
      t.string  :description
      t.string  :state, null: false, index: true
      t.timestamps null: false
    end
  end
end
