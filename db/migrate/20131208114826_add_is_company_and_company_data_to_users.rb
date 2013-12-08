class AddIsCompanyAndCompanyDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_company, :boolean, null: false, default: false
    add_column :users, :company_data, :hstore
    add_index  :users, :is_company
  end
end
