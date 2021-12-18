class FoldersController < APIController
  include UserSupport::EnforceMe

  before_action :enforce_me_id, only: [:index, :create]

  def index
    render json: current_user.folders
  end

  def show
    render json: folder
  end

  def create
    response = CreateFolderService.call(folder_params.merge(user: current_user))

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def update
    response = UpdateFolderService.call(folder, folder_params)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def destroy
    response = DestroyFolderService.call(folder)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  private

  def folder
    @folder ||= Folder.find(params[:id])
  end

  def folder_params
    require(:folder).permit(:name, :parent_folder_id)
  end
end

