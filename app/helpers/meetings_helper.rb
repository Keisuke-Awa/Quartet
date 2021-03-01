module MeetingsHelper
  require 'date'

  def calculate_day_of_week(datetime)
    %w(日 月 火 水 木 金 土)[datetime.wday]
  end
end
