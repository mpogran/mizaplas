class User < ApplicationRecord
  include UserSupport::Resource

	has_secure_password
  join_associations :recipes, :folders, :lists

	validates :email, presence: true, uniqueness: true

  def favorite(resource)
    public_send("favorite_#{resource.pluralize}")
  end
end
