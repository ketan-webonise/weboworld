class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in @user, :event => :authentication
      redirect_to user_posts_path(@user)
    else
      session["users.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end


end