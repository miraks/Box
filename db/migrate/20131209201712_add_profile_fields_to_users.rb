class AddProfileFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile, :hstore
    add_column :users, :avatar, :string
  end
end
