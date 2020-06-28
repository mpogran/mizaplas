class User < ApplicationRecord
  include UserSupport::Resource

	has_secure_password
  join_associations :recipes, :folders, :lists

	validates :email, presence: true, uniqueness: true
end
