class FavoritesController < APIController
  include UserSupport::EnforceMe
  include ResourceSupport::ResourceType

  FAVORITEABLE_RESOURCES = %w(Recipe Folder List).freeze

  before_action :enforce_me_id


  def index
    render json: Favorite.all(user: current_user, resource_klass_name: resource_klass_name)
  end

  def create
    response = CreateFavoriteService.call(current_user, params)

    if response.success?
      render json: response.favorite
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def destroy
    resource_user = Favorite.find(
      user: current_user,
      resource_klass_name: resource_klass_name,
      id: params[:id]
    )
    response = DestroyFavoriteService.call(resource_user)

    if response.success?
      render json: response.favorite
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end
end
