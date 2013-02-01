class PasswordsController < Devise::PasswordsController
  # GET /resource/password/edit?reset_password_token=abcdef
  #skip_before_filter :require_no_authentication
  #skip_before_filter :assert_reset_token_passed, :only => :edit
  #def edit
  #  rest_password_token='t7qWVxs5HYAPB5vSxFpN'
  #  self.resource = resource_class.new
  #  resource.reset_password_token = rest_password_token
  #  render :'devise/passwords/edit'
  #end
  #
  ## PUT /resource/password
  #def update
  #  self.resource = resource_class.reset_password_by_token(resource_params)
  #
  #  if resource.errors.empty?
  #    resource.unlock_access! if unlockable?(resource)
  #    flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
  #    set_flash_message(:notice, flash_message) if is_navigational_format?
  #    #sign_in(resource_name, resource)
  #    respond_with resource, :location => after_sign_in_path_for(resource)
  #  else
  #    respond_with resource
  #  end
  #end
  #
  #def after_change_password(resource_name, resource)
  #  new_session_path(resource_name)
  #end
end
