class CreateUserService < ApplicationService
  attr_reader :params, :user

  def initialize(params, opts={})
    super

    @params = params
  end

  def call
    @user = User.new(params)

    user.save ? handle_success : handle_failure
    response
  end

  def handle_success
    response.success!
    UserMailer.user_created(user)
  end

  def handle_failure
    response.errors.merge!(user.errors)
  end
end
