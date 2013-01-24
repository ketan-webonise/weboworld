class InvitesController < ApplicationController
  def index
    token = params[:token]
    #@contacts = GmailContacts::Google.new("some_token").contacts
    logger.inspect("#######################################{@contacts.info}");
  end
end
