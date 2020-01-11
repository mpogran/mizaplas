module  JoinAssociation
  extend ActiveSupport::Concern

  class_methods do
    def join_associations(*associations)
      @join_associations = associations

      default_options = {
        inverse_of: self.name.underscore.to_sym
      }

      associations.each do |association|
        build_join_association(association, default_options)
      end
    end

    def reflect_on_join_associations
      @join_associations || []
    end

    private

    def build_join_association(association, options)
      JoinAssociations::Builder.build_has_many(self, association, options)
    end
  end
end
