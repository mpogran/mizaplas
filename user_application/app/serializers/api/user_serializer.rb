class Api::UserSerializer < ActiveModel::Serializer
  attributes :name, :email

  has_many :recipes
  has_many :folders
  has_many :lists
end
