class ResourceUsersController < APIController
  include ResourceSupport::ResourceType

  def index
    render json: resource.users
  end

  def create
    response = CreateResourceUserService.call(resource, current_user)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  def destroy
    response = DestroyResourceUserService.call(resource_user)

    if response.success?
      render json: response.user
    else
      render status: :unprocessable_entity, json: response.errors.details
    end
  end

  private

  def resource_user_klass
    return unless resource_klass_name
    "#{resource_klass_name}User".safe_constantize
  end

  def resource_user
    return @resource_user if defined?(@resource_user)

    unless resource_user_klass && params[:id]
      raise ActiveRecord::RecordNotFound, 'Invalid Resource'
    end

    @resource_user = resource_user_klass.find(params[:id])
  end
end
