class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :remember_token, :string
    # Indexed - So that users can be retrieved by remember_token
    add_index  :users, :remember_token
  end
end
