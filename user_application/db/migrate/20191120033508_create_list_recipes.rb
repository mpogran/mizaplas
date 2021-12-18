class CreateListRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :list_recipes do |t|
      t.references :list, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
      t.timestamp :deleted_at
    end
  end
end
