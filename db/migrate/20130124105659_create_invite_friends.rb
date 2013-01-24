class CreateInviteFriends < ActiveRecord::Migration
  def change
    create_table :invite_friends do |t|
      t.string :friend_email
      t.references :user

      t.timestamps
    end
    add_index :invite_friends, :user_id
  end
end
