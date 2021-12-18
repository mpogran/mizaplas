class UserList < ApplicationRecord
  include ResourceSupport::JoinModel

  belongs_to :user
  belongs_to :list
end
