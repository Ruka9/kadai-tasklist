class AddUserToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :content, :string
    add_reference :users, :user, foreign_key: true
  end
end
