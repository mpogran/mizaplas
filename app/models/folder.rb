class Folder < ApplicationRecord
  include ResourceSupport::Resource
  include SoftDelete

  has_many :recipes

  validates :name, presence: true
end
