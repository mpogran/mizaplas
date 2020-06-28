class UsersController < APIController
  def show
    render json: @user
  end

  def create
    CreateUserService.call(creation_params)

    render json: @user
  end

  def update
    render json: @user
  end

  def destroy
    head :ok
  end

  def user
    @user ||= User.find(params[:id])
  end
end
