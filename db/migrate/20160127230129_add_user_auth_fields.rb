class AddUserAuthFields < ActiveRecord::Migration
  def change
  	add_column :user_authentications, :user_id, :integer, index: true
  	add_column :user_authentications, :provider, :string

  end
end
