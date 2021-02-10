Ransack.configure do |config|
  require 'date'

  config.add_predicate :equals_date,
      arel_predicate: :between,
      formatter: proc { |v|
        if Date.parse(v.to_s) == Date.today
          DateTime.now...DateTime.parse((v + 1.days).to_s)
        else
          DateTime.parse(v.to_s)...DateTime.parse((v + 1.days).to_s)
        end
      },
      type: :datetime
end