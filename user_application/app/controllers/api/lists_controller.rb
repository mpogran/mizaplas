class ListsController < APIController
  include UserSupport::EnforceMe

  before_action :enforce_me_id, only: [:index, :create]

  def index
    render json: current_user.lists
  end

  def show
    render json: list
  end

  def create
    response = CreateListService.call(list_params.merge(user: current_user))

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def update
    response = UpdateListService.call(list, list_params)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def destroy
    response = DestroyListService.call(list)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  private

  def list
    @list ||= List.find(params[:id])
  end

  def list_params
    require(:list).permit(:title)
  end
end

