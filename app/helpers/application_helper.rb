module ApplicationHelper

  def self? user
    logged_in? and current_user == user
  end

end
