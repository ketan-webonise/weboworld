class InvitesController < ApplicationController
  before_filter :authenticate_user! , :only => [:invite_manually]
  def index
  end

  def invite_manually
  end

  def send_mail
    InviteFriendMailer.invite_friends(current_user.email,params[:email]).deliver
    redirect_to root_path , :notice => "Invitation has been sent to your contacts."

  end

  #def search_emails
  #  @emails = InviteFriend.where("'name' like ?", "%#{params[:q]}%")
  #  respond_to do |format|
  #    format.html
  #    format.json { render :json => @emails.map(&:attributes) }
  #  end
  #end
end
