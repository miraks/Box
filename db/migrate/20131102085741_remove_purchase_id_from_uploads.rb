class RemovePurchaseIdFromUploads < ActiveRecord::Migration
  def change
    remove_column :uploads, :purchase_id, :integer
  end
end
