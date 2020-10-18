class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :secret_santa_id
      t.integer :matched_user_id

      t.timestamps
    end
  end
end
