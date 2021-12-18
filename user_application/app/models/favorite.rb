class Favorite
  FAVORITEABLE_RESOURCES = %w(Recipe Folder List)

  class << self
    def all(user:, resource_klass_name: nil)
      Array(resource_klasses || FAVORITEABLE_RESOURCES).flat_map do |resource|
        user.public_send("favorite_#{resource.to_s.tableize}")
      end
    end

    def find(user:, resource_klass_name:, id:)
      user
        .public_send("favorite_user_#{resource_klass_name.tableize}")
        .find_by("#{resource_klass_name.underscore}_id" => id)
    end
  end
end
