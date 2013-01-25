
require 'net/http'
require 'net/https'
require 'uri'
require 'rexml/document'

class ImportController < ApplicationController

  def authenticate
    @title = "Google Authetication"

    client_id = APP_ID
    google_root_url = "https://accounts.google.com/o/oauth2/auth?state=profile&redirect_uri="+googleauth_url+"&response_type=code&client_id="+client_id.to_s+"&approval_prompt=force&scope=https://www.google.com/m8/feeds/"
    redirect_to google_root_url
  end

  def authorise
    begin
      @title = "Google Authetication"
      token = params[:code]
      client_id = APP_ID
      client_secret = APP_SECRET
      uri = URI('https://accounts.google.com/o/oauth2/token')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new(uri.request_uri)

      request.set_form_data('code' => token, 'client_id' => client_id, 'client_secret' => client_secret, 'redirect_uri' => googleauth_url, 'grant_type' => 'authorization_code')
      request.content_type = 'application/x-www-form-urlencoded'
      response = http.request(request)
      response.code
      access_keys = ActiveSupport::JSON.decode(response.body)

      uri = URI.parse("https://www.google.com/m8/feeds/contacts/default/full?oauth_token="+access_keys['access_token'].to_s+"&max-results=50000&alt=json")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      contacts = ActiveSupport::JSON.decode(response.body)
      emails=contacts['feed']['entry'].collect{|i| i["gd$email"]}.collect{|i| i.first["address"]}
      user = User.find(current_user.id)
      emails.each do |email|
        InviteFriend.create(:friend_email => email,:user_id => current_user.id)
        InviteFriendMailer.invite_friends(user.email,email).deliver
      end
    rescue Exception => ex
      ex.message
    ensure
      redirect_to root_path , :notice => "Invite or follow your Google contacts."
    end
  end
end

