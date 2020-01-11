class ListIngredient < ApplicationRecord
  include SoftDelete

  belongs_to :list
  belongs_to :ingredient

  validates :list, :ingredient, presence: true
  validates :quantity, numericality: {greater_than_or_equal_to: 0}

  scope :open, -> { where(closed_at: nil) }
  scope :closed, -> { where.not(closed_at: nil) }
end
