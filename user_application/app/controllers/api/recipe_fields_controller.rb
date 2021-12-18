class RecipeFieldsController < APIController
  def create
    response = CreateRecipeFieldService.call(create_params.merge(recipe: recipe))

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def update
    response = UpdateRecipeFieldService.call(recipe_field, update_params)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def destroy
    response = DestroyRecipeFieldService.call(recipe_field)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  private

  def recipe
    @recipe ||= Recipe.find(params[:recipe_id])
  end

  def recipe_field
    @recipe_field ||= RecipeField.find(params[:id])
  end

  def create_params
    params.require(:recipe_field).permit(:type, :value)
  end

  def update_params
    params.require(:recipe_field).permit(:value)
  end
end
