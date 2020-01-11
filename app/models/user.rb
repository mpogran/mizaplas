class User < ApplicationRecord
  include UserSupport::Resource

  join_associations :recipes, :folders, :lists
end
