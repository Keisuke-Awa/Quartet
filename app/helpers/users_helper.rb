module UsersHelper
  require 'date'

  def calculate_age(user)
    today_i = Date.today.strftime("%Y%m%d").to_i
    birthdate_i = user.birth_date.strftime("%Y%m%d").to_i
    return (today_i - birthdate_i) / 10000
  end
end
