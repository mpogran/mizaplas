module ResourceSupport::ResourceType
  def resource_klass_name
    return if (resource_type = params[:resource_type]).blank?
    resource_type.classify
  end

  def resource_klass
    resource_klass_name&.safe_constantize
  end

  def resource
    return @resource if defined?(@resource)

    unless resource_klass && params[:resource_id]
      raise ActiveRecord::RecordNotFound, 'Invalid Resource'
    end

    @resource = resource_klass.find(params[:resource_id])
  end
end

