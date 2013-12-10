class AddDefaultToUsersHstoreFields < ActiveRecord::Migration
  def up
    company_datas = User.where(company_data: nil).pluck(:id).each_with_object({}) do |id, res|
      res[id] = { company_data: "''::hstore" }
    end
    User.update_numerous company_datas

    profiles = User.where(profile: nil).pluck(:id).each_with_object({}) do |id, res|
      res[id] = { profile: "''::hstore" }
    end
    User.update_numerous profiles

    change_column_default :users, :company_data, ''
    change_column_default :users, :profile, ''
  end

  def down
    change_column_default :users, :company_data, nil
    change_column_default :users, :profile, nil
  end
end
