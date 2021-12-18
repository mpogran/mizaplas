class RecipesController < APIController
  include UserSupport::EnforceMe

  before_action :enforce_me_id, only: [:index, :create]

  def index
    render json: current_user.recipes
  end

  def show
    render json: recipe
  end

  def create
    response = CreateRecipeService.call(recipe_params.merge(user: current_user))

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def update
    response = UpdateRecipeService.call(recipe, recipe_params)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def destroy
    response = DestroyRecipeService.call(recipe)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  private

  def recipe
    @recipe ||= Recipe.find(params[:id])
  end

  def recipe_params
    require(:recipe).permit(
      :title, :author, :source, :instructions, field: [:type, :value]
    )
  end
end

