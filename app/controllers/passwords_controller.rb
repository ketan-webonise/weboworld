class PasswordsController < Devise::PasswordsController
  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    render :'devise/passwords/edit'
  end

  # PUT /resource/password
  def update
    self.resource = resource_class
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_navigational_format?
      #sign_in(resource_name, resource)
      #respond_with resource, :location => after_sign_in_path_for(resource)
      respond_with_navigational(resource){ redirect_to after_change_password(resource_name, resource) }
    else
      respond_with resource
    end
  end

  def after_change_password(resource_name, resource)
    new_session_path(resource_name)
  end
end
