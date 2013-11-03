class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :recepient, class_name: 'User', foreign_key: 'recipient_id'

  validates :title, :body, presence: true

end