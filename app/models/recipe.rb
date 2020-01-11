class Recipe < ApplicationRecord
  include ResourceSupport::Resource
  include SoftDelete
  include JoinAssociation

  belongs_to :folder
  has_many :fields, class_name: 'RecipeField'

  join_associations :ingredients

  validates :source, :title, :author, :instructions, :folder, presence: true
end
