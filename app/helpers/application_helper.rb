module ApplicationHelper

  def self? user
    logged_in? and current_user == user
  end

  def void
    'javascript:void(0)'
  end

end
