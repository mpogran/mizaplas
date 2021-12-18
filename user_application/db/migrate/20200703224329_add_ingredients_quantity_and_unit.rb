class AddIngredientsQuantityAndUnit < ActiveRecord::Migration[5.2]
  def change
    add_column :list_ingredients, :unit, :string
    add_column :recipe_ingredients, :quantity, :decimal, default: 0
    add_column :recipe_ingredients, :unit, :string
  end
end
