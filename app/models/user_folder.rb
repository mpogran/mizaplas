class UserFolder < ApplicationRecord
  include ResourceSupport::JoinModel

  belongs_to :user
  belongs_to :folder

  scope :favorite, -> { where(favorite: true) }
end
