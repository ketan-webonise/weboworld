class SessionsController < Devise::PasswordsController
  skip_filter :require_no_authentication,:assert_reset_token_passed, :only => [:edit, :update]

  def edit
    self.resource = resource_class.new
    render :'sessions/edit'
  end
  def update
    #self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    self.resource = resource_class.reset_password_by_token(resource_params)
    #if resource.update_with_password(resource_params)
    #
    #end
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with resource, :location => after_sign_in_path_for(resource)
    else
      respond_with resource
    end
  end
end
