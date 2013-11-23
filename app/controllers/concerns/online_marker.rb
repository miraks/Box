module OnlineMarker
  extend ActiveSupport::Concern

  included do
    before_filter :mark_as_online
  end

  def mark_as_online
    return true unless logged_in?
    current_user.online!
  end
end