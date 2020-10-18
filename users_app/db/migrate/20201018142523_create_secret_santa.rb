class CreateSecretSanta < ActiveRecord::Migration[6.0]
  def change
    create_table :secret_santas do |t|
      t.string :group_name

      t.timestamps
    end
  end
end
