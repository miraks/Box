class AddPurchaseIdToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :purchase_id, :integer
  end
end
