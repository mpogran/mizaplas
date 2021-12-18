class ListRecipe < ApplicationRecord
  include SoftDelete

  belongs_to :list
  belongs_to :recipe

  validates :list, :recipe, presence: true
end
