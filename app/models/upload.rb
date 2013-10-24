class Upload < ActiveRecord::Base

  belongs_to :user
  belongs_to :folder

  validates :name, :original_name, :user_id, :user_folder_id, presence: true

end