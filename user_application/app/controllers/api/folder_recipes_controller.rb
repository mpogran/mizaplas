class FolderRecipesController < APIController
  def index
    render json: folder.recipes
  end

  def create
    response = CreateFolderRecipeService.call(folder_recipe_params.merge(folder: folder))

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def destroy
    response = DestroyFolderRecipeService.call(folder_recipe)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  private

  def folder
    @folder ||= Folder.find(params[:folder_id])
  end

  def folder_recipe
    @folder_recipe ||= FolderRecipe.find(params[:id])
  end

  def folder_recipe_params
    params.require(:folder_recipe).permit(:id)
  end
end

