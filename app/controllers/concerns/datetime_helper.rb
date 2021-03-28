module DatetimeHelper

  def calculate_day_of_week(datetime)
    ["(日)", "(月)", "(火)", "(水)", "(木)", "(金)", "(土)"][datetime.wday]
  end

  def initialize_four_weeks
    four_weeks = [(0..6), (7..13), (14..20), (21..27)]
    four_weeks.map { |week| week.map {|i| Date.today + i.days } }
  end

  def initialize_date
    four_weeks = (0..27).map do |i| 
      date_value = Date.today + i.days 
      date_key = date_value.strftime("%-m月%-d日") + calculate_day_of_week(date_value)
      next [date_key, date_value]
    end
    return { date: four_weeks }
  end

  def initialize_time
    hours = []
    23.times { |n| hours.push(["#{n+1}時", n+1]) }
    minutes = [0, 15, 30, 45].map { |minute| ["#{minute}分", minute]}
    return { hour: hours, minute: minutes }
  end

  def initialize_datetime
    time = initialize_time
    date = initialize_date
    date_and_time = time.merge(date)
  end

end