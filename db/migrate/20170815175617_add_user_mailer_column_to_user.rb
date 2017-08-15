class AddUserMailerColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :confirm_email, :boolean , :default => false
    add_column :users, :confirm_token, :string
  end
end
