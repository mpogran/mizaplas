class ListRecipesController < APIController
  def create
    response = CreateListRecipeService.call(list_recipe_params.merge(list: list))

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def destroy
    response = DestroyListRecipeService.call(list_recipe)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  private

  def list
    @list ||= List.find(params[:list_id])
  end

  def list_recipe
    @list_recipe ||= ListRecipe.find(params[:id])
  end

  def list_recipe_params
    params.require(:list_recipe).permit(:id)
  end
end

