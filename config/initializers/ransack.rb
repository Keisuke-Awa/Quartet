Ransack.configure do |config|
  config.add_predicate :equals_date,
      arel_predicate: :between,
      formatter: proc { |v|
        Time.parse(v.to_s)...Time.parse((v + 1.days).to_s)
      },
      type: :datetime
end