class CreateRecipeFields < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_fields do |t|
      t.references :recipe, null: false, foreign_key: true
      t.string :type, null: false
      t.string :value, null: false

      t.timestamps
      t.timestamp :deleted_at
    end
  end
end
