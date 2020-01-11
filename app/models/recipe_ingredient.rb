class RecipeIngredient < ApplicationRecord
  include SoftDelete

  belongs_to :recipe
  belongs_to :ingredient

  validates :recipe, :ingredient, presence: true
end
