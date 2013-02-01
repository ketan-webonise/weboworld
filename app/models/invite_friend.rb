require 'net/http'
require 'net/https'
require 'uri'
require 'rexml/document'
class InviteFriend < ActiveRecord::Base
  belongs_to :user
  attr_accessible :friend_email, :user_id, :email_tokens, :name
  validates :user_id, presence: true
  validate :friend_email, presence: true
  attr_reader :email_tokens

  #def self.get_email(id)
  #  friend_info = InviteFriend.find(id)
  #  return friend_info.friend_email
  #end

  # fetching google contact
  def self.get_google_user_contact(code)
    begin
      @title = "Google Authetication"
      token = code
      client_id = APP_ID
      client_secret = APP_SECRET
      uri = URI('https://accounts.google.com/o/oauth2/token')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new(uri.request_uri)

      request.set_form_data('code' => token, 'client_id' => client_id, 'client_secret' => client_secret, 'redirect_uri' => 'http://local.weboworld.com/import/authorise', 'grant_type' => 'authorization_code')
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
      emails
    end
  end

  #sending mail to google friends on invite activity
  def self.send_invitation_mails(emails,user)
    emails.each do |email|
      InviteFriend.create(:friend_email => email,:user_id => user.id, :name => email[/[^@]+/])
      InviteFriendMailer.invite_friends(user.email,email).deliver
    end
  end

end
