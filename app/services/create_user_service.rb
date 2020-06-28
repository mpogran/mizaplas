class CreateUserService < ApplicationService
  attr_reader :params

  def initialize(params, opts={})
    super

    @params = params
  end

  def call
    User.create(params)
    observers.notify('users.create')
  end
end
