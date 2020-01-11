module ResourceSupport::Resource
  extend ActiveSupport::Concern

  included do
    default_options = {
      inverse_of: self.name.underscore,
      transpose: true,
    }

    owner_options = default_options.merge(
      scope: :owned,
      alias: :owner,
      source: :user
    )

    JoinAssociations::Builder.build_has_many(self, :users, default_options)
    JoinAssociations::Builder.build_has_one(self, :user, owner_options)

    def join_user_klass
      "User#{self.class.name}".constantize
    end
  end
end

