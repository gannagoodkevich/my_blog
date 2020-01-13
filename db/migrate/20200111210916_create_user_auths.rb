class CreateUserAuths < ActiveRecord::Migration[6.0]
  def change
    create_table :user_auths do |t|
      t.string :email
      t.string :encrypted_password, :null => false, :default => ""

      # Confirmable
      t.string :conf_token
      t.datetime :confirmed_at
      t.datetime :confirm_sent_at
    end

    add_index :user_auths, :email, :unique => true
    add_index :user_auths, :conf_token, :unique => true
  end
end
