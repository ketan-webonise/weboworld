class InvitesController < ApplicationController
  def index
    #token = params[:token]
    #@contacts = GmailContacts::Google.new("some_token").contacts
    #logger.inspect("#######################################{@contacts.info}");
  end

  def invite_manually

  end

  def send_mail

  end

  def search_emails
    @emails = InviteFriend.all
    respond_to do |format|
      format.json { render :json => @emails.map(&:attributes) }
    end
  end
end
