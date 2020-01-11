class List < ApplicationRecord
  include ResourceSupport::Resource
  include SoftDelete
  include JoinAssociation

  join_associations :ingredients, :recipes

  validates :title, presence: true
end
