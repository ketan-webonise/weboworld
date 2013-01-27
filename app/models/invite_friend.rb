class InviteFriend < ActiveRecord::Base
  belongs_to :user
  attr_accessible :friend_email, :user_id
  validates :user_id, presence: true
  validate :friend_email, presence: true
end
