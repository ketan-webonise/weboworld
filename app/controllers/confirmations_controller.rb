class ConfirmationsController < Devise::ConfirmationsController

  #overriding confirmation controller to redirect user to sign up page after clicking on confirmation link in mail
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render :new }
    end
  end

  def after_confirmation_path_for(resource_name, resource)
    new_session_path(resource_name)
  end
end
