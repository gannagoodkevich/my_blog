class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :active
      t.integer :organization_id
      t.integer :post_id
      t.string :email
      t.string :encrypted_password, :null => false, :default => ""

      t.string :conf_token
      t.datetime :confirmed_at
      t.datetime :confirm_sent_at

      t.timestamps
    end

    add_index :users, :email, :unique => true
    add_index :users, :conf_token, :unique => true
  end
end
