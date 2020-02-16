class CreateFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :folders do |t|
      t.string :name
      t.integer :parent_folder_id, index: true

      t.timestamps
      t.timestamp :deleted_at
    end
  end
end
