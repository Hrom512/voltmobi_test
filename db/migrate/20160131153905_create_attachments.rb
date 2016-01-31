class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.belongs_to :task, null: false, index: true
      t.attachment :file, null: false
      t.timestamps null: false
    end
  end
end
