class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :active
      t.integer :organization_id
      t.integer :post_id

      t.timestamps
    end
  end
end
