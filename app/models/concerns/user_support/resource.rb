module UserSupport::Resource
  extend ActiveSupport::Concern
  include JoinAssociation

  class_methods do
    private

    def build_join_association(association, options)
      JoinAssociations::Builder.build_has_many(self, association, options)
      JoinAssociations::Builder.build_has_many(self, association, options.merge(scope: :favorite))
      JoinAssociations::Builder.build_has_many(self, association, options.merge(scope: :owned))
      JoinAssociations::Builder.build_has_many(self, association, options.merge(scope: :unowned))
    end
  end
end

