class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :title

      t.timestamps
      t.timestamp :deleted_at
    end
  end
end
