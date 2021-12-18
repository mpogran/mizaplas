module UserSupport::EnforceMe
  def enforce_me_id
    return if params[:id] == 'me'
    head :unauthorized
  end
end
