
require 'net/http'
require 'net/https'
require 'uri'
require 'rexml/document'

class ImportController < ApplicationController

  #send request to google to get google contact scope
  def authenticate
    @title = "Google Authetication"

    client_id = APP_ID
    google_root_url = "https://accounts.google.com/o/oauth2/auth?state=profile&redirect_uri="+googleauth_import_index_url+"&response_type=code&client_id="+client_id.to_s+"&approval_prompt=force&scope=https://www.google.com/m8/feeds/"
    redirect_to google_root_url
  end

  #callback method from google to handle code
  def authorise
    begin
      emails = InviteFriend.get_google_user_contact(params[:code])
      user = User.find(current_user.id)
      InviteFriend.send_invitation_mails(emails,user)
      flash[:success] = "Invitation has been sent to your Google contacts."
    rescue Exception => ex
      logger.info ex.message
      flash[:error] = "Invitation to Ur Google friends failed"
    end
    redirect_to root_path
  end
end

