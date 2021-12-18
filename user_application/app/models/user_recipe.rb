class UserRecipe < ApplicationRecord
include ResourceSupport::JoinModel

  belongs_to :user
  belongs_to :recipe

  scope :favorite, -> { where(favorite: true) }
end
