class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :author
      t.boolean :tester

      t.timestamps
    end
  end
end
