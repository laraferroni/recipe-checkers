class AutoApprovals < ActiveRecord::Migration
  def change

  	create_table :author_whitelists do |t|
    	t.references :user
    	t.integer :tester_id
      t.timestamps
  	end

  	create_table :author_blacklists do |t|
  		t.references :user
    	t.integer :tester_id
      t.timestamps
  	end
  end
end
