class RecipeField < ApplicationRecord
  include SoftDelete

  belongs_to :recipe

  validates :recipe, :type, :value, presence: true
end
