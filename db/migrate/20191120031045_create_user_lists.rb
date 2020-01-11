class CreateUserLists < ActiveRecord::Migration[5.2]
  def change
    create_table :user_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :list, null: false, foreign_key: true
      t.boolean :owner, null: false, default: false
      t.boolean :favorite, null: false, default: false

      t.timestamps
      t.timestamp :deleted_at
    end
  end
end
