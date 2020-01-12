class CreateUserAuths < ActiveRecord::Migration[6.0]
  def change
    create_table :user_auths do |t|
      t.string :email, :null => false
      t.string :password, :null => false, :dafault => ""

      # Confirmable
      t.string :conf_token
      t.datetime :confirmed_at
      t.datetime :confirm_sent_at
    end

    add_index :user_auths, :email, :unique => true
    add_index :user_auths, :conf_token, :unique => true
  end
end
