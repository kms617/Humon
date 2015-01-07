class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :device_token, null: false
      t.timestamps null: false
    end

    add_index :users, :device_token, unique: true
  end
end
