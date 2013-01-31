class AddNameToInviteFriends < ActiveRecord::Migration
  def up
    add_column :invite_friends, :name, :string
  end

  def down
    remove_column :invite_friends, :name
  end
end
