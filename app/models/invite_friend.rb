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

end
