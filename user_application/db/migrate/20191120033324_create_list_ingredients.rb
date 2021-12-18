class CreateListIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :list_ingredients do |t|
      t.references :list, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.decimal :quantity, null: false, default: 0

      t.timestamps
      t.timestamp :closed_at
      t.timestamp :deleted_at
    end
  end
end
