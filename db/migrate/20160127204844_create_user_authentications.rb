class CreateUserAuthentications < ActiveRecord::Migration
  def change
    create_table :user_authentications do |t|

      t.timestamps
    end
  end
end
