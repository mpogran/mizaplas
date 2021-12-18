class UsersController < ApplicationController
  include UserSupport::EnforceMe

  before_action :enforce_me_id, except: :create

  def show
    render json: user
  end

  def create
    response = CreateUserService.call(user_params)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def update
    response = UpdateUserService.call(user, user_params)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def destroy
    head :not_implemented
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def user
    @user ||= current_user
  end
end
