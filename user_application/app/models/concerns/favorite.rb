module Favorite
  extend ActiveSupport::Concern

  included do
    def toggle_favorite!(user)
      return false unless defined?(:join_user_klass)
      return false unless (join_assoc = join_user_klass.find_by(user: user))

      join_assoc.toggle!(:favorite)
    end
  end
end
