class ListIngredientsController < APIController
  def create
    response = CreateListIngredientService.call(list_ingredient_params.merge(list: list))

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def update
    response = UpdateListIngredientService.call(list_ingredient, list_ingredient_params)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def destroy
    response = DestroyListIngredientService.call(list_ingredient)

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

  def list_ingredient
    @list_ingredient ||= ListIngredient.find(params[:id])
  end

  def list_ingredient_params
    params.require(:list_ingredient).permit(:name, :quantity, :unit)
  end
end
