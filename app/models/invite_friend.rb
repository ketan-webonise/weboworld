class InviteFriend < ActiveRecord::Base
  belongs_to :user
  attr_accessible :friend_email, :user_id, :email_tokens
  validates :user_id, presence: true
  validate :friend_email, presence: true
  attr_reader :email_tokens

end
