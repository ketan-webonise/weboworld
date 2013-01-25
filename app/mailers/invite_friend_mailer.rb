class InviteFriendMailer < ActionMailer::Base
  default from: "pansingh@weboniselab.com"
  def invite_friends(user,email)
    mail(:to => email, :subject => "Invitation for WeboWorld")
  end
end
