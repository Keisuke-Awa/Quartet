module ApplicationHelper

  require "date"

  include DatetimeHelper

  def current_user?(user)
    user && user == current_user
  end

  
end
