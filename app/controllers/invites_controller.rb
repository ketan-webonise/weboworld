class InvitesController < ApplicationController
  def index
    #token = params[:token]
    #@contacts = GmailContacts::Google.new("some_token").contacts
    #logger.inspect("#######################################{@contacts.info}");
  end

  def invite_manually
    @emails = InviteFriend.new

  end

  def send_mail
    InviteFriendMailer.invite_friends(current_user.email,params[:email]).deliver
    redirect_to root_path , :notice => "Invitation has been sent to your contacts."

  end

  def search_emails
    @emails = InviteFriend.where("friend_email like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json { render :json => @emails.map(&:attributes) }
    end
  end
end
