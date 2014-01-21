module ApplicationHelper

  def self? user
    logged_in? and current_user == user
  end

  # move
  def except arr, what
    arr - Array.wrap(what)
  end

end
