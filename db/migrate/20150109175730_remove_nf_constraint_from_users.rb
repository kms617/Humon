class RemoveNfConstraintFromUsers < ActiveRecord::Migration
  def up
    change_column :users, :device_token, :string, null: true
  end

  def down
    change_column :users, :device_token, :string, null: false
  end
end
