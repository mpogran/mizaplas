class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.references :folder, foreign_key: true
      t.string :source
      t.string :title
      t.string :author
      t.text :instructions

      t.timestamps
      t.timestamp :deleted_at
    end
  end
end
