class AddTwitterHandleToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :twitter_handle, :string, null: false, default: ""

    add_index :users, :twitter_handle, unique: true
  end
end
