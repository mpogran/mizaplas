class RecipeIngredientsController < APIController
  def create
    response = CreateRecipeIngredientService.call(recipe_ingredient_params.merge(recipe: recipe))

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def update
    response = UpdateRecipeIngredientService.call(recipe_ingredient, recipe_ingredient_params)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def destroy
    response = DestroyRecipeIngredientService.call(recipe_ingredient)

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

  def recipe_ingredient
    @recipe_ingredient ||= RecipeIngredient.find(params[:id])
  end

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:name, :quantity, :unit)
  end
end
