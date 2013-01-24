class InviteFriend < ActiveRecord::Base
  belongs_to :user
  attr_accessible :friend_email
end
