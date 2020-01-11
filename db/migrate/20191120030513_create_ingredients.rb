class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :name

      t.timestamps
      t.timestamp :deleted_at
    end
  end
end
