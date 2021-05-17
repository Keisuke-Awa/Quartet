# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pref = ["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県",
  "茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県",
  "新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県",
  "静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県",
  "奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県",
  "徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県",
  "熊本県","大分県","宮崎県","鹿児島県","沖縄県"]

occupation = ['上場企業', '金融', '公務員', 'コンサル', '経営者・役員']

educational_bg = ['高校卒', '短大/専門学校/大学院卒', '大学卒', '大学院卒', 'その他']

annual_income = [['200万円未満', nil, 200], ['200万円以上〜400万円未満', 200, 400],
  ['400万円以上〜600万円未満', 400, 600], ['600万円以上〜800万円未満', 600, 800],
  ['800万円以上〜1000万円未満', 800, 1000], ['1000万円以上〜1500万円未満', 1000, 1500], 
  ['1500万円以上〜2000万円未満', 1500, 2000], ['2000万円以上〜3000万円未満', 2000, 3000], ['3000万円以上', 3000, nil]]

smoking_status = ['吸わない', '吸う', '吸う（電子タバコ）', '時々吸う', '非喫煙者の前では吸わない']

def rand_time(from, to)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

def make_appointment(appointment, other_user)
  appointments << appointment
  other_user.appointments << appointment
end


pref.each { |p| PrefectureMst.create!(prefecture_name: p)}
occupation.each { |op| OccupationMst.create!(occupation_name: op)}
educational_bg.each { |eb| EducationalBgMst.create!(ebg_name: eb)}
annual_income.each { |ai| AnnualIncomeMst.create!(income_range: ai[0], amount_or_more: ai[1], less_than_amount: ai[2])}
smoking_status.each { |st| SmokingMst.create!(smoking_status: st)}

Place.create!(name: "新宿", prefecture_id: 13)
Place.create!(name: "池袋", prefecture_id: 13) 
Place.create!(name: "渋谷", prefecture_id: 13)

ActiveRecord::Base.transaction do
  300.times do |n|
    email = "rails#{n+1}@sample.com"
    password = "password"
    birth_date = Faker::Date.birthday(min_age: 20, max_age: 40)
    if n < 150
      name = "#{Faker::Name.name}太"
      sex = '1'
      height = Faker::Number.within(range: 150..190)
      weight = Faker::Number.within(range: 50..80)
      blood_type = "A"
      birthplace_id = Faker::Number.within(range: 1..47)
      occupation_id = Faker::Number.within(range: 1..5)
      educational_bg_id = Faker::Number.within(range: 1..5)
      annual_income_id = Faker::Number.within(range: 1..9)
      smoking_status_id = Faker::Number.within(range: 1..5)
      introduction = Faker::Lorem.sentence
      user = User.create!(name: name, email: email, password: password, password_confirmation: password, birth_date: birth_date,
        sex: sex, residence_id: 13)
      user.create_user_profile!(height: height, weight: weight, blood_type: blood_type, birthplace_id: birthplace_id,
        occupation_id: occupation_id, educational_bg_id: educational_bg_id, annual_income_id: annual_income_id,
        smoking_status_id: smoking_status_id, introduction: introduction)
    else
      name = "#{Faker::Name.name}子"
      sex = '2'
      user = User.create!(name: name, email: email, password: password, password_confirmation: password, birth_date: birth_date,
        sex: sex, residence_id: 13)
      user.create_user_profile!
    end
    # image_url = Faker::Avatar.image(slug: email, size: '150x150')
    # user.avatar.attach(io: URI.parse(image_url).open, filename: 'avatar.png')
    user.avatar.attach(io: File.open(Rails.root.join('src', 'js', 'modules', 'images', 'yumikoIMGL7854_TP_V.jpg')), filename: 'avater.jpeg',
    content_type: 'image/jpg')
  end
end

ActiveRecord::Base.transaction do
  300.times do |n|
    count = 0
    while count < 5
      detail = Faker::Lorem.sentence
      meet_at = rand_time(Time.now, 21.days.since)
      people = rand(6) + 2
      place_id = rand(Place.count) + 1
      user = User.find(n + 1)
      meeting = Meeting.create!(detail: detail, meet_at: meet_at, people: people, place_id: place_id, planning_user_id: user.id)

      10.times do |an|
        if n < 140
          application_detail = Faker::Lorem.sentence
          applicant = User.find(n + 151)
          MeetingApplication.create!(detail: application_detail, meeting_id: meeting.id, applicant_id: applicant.id + an)
        elsif 140 <= n && n < 150
          application_detail = Faker::Lorem.sentence
          applicant = User.find(n + 151)
          MeetingApplication.create!(detail: application_detail, meeting_id: meeting.id, applicant_id: applicant.id - an)
        elsif 150 <= n && n < 290
          application_detail = Faker::Lorem.sentence
          applicant = User.find(n - 149)
          MeetingApplication.create!(detail: application_detail, meeting_id: meeting.id, applicant_id: applicant.id + an)
        elsif 290 <= n && n < 300
          application_detail = Faker::Lorem.sentence
          applicant = User.find(n - 151)
          MeetingApplication.create!(detail: application_detail, meeting_id: meeting.id, applicant_id: applicant.id - an)
        end
      end
      count += 1
    end
  end
end

ActiveRecord::Base.transaction do
  300.times do |n|
    meeting = User.find(n + 1).meetings.first
    meeting_application = meeting.meeting_applications.first
    appointment = Appointment.create!(meeting_id: meeting.id)
    meeting.planning_user.make_appointment(appointment, meeting_application.applicant)
    meeting.update!( appointment_id: appointment.id )
    meeting.meeting_applications.delete_all
  end
end

ActiveRecord::Base.transaction do
  300.times do |n|
    meeting = User.find(n + 1).meetings.last
    meeting_application = meeting.meeting_applications.first
    appointment = Appointment.create!(meeting_id: meeting.id)
    meeting.planning_user.make_appointment(appointment, meeting_application.applicant)
    meeting.update!( appointment_id: appointment.id )
    meeting.meeting_applications.delete_all
  end
end

cmeal = TagCategory.create!(category_name: "料理")
catmosphere = TagCategory.create!(category_name: "雰囲気")
cother = TagCategory.create!(category_name: "その他")

tag1 = Tag.create!(name: "辛いもの", tag_category_id: cmeal.id)
tag1.children.create!(name: "麻婆豆腐")
tag1.children.create!(name: "エビチリ")
tag2 = Tag.create!(name: "肉料理", tag_category_id: cmeal.id)
tag2.children.create!(name: "焼肉")
tag2.children.create!(name: "サムギョプサル")
tag2_1 = tag2.children.create!(name: "鳥料理")
tag2_1.children.create!(name: "焼き鳥")


Tag.create!(name: "にぎやか", tag_category_id: catmosphere.id)
Tag.create!(name: "落ち着いた", tag_category_id: catmosphere.id)
Tag.create!(name: "夜景がきれい", tag_category_id: catmosphere.id)

Tag.create!(name: "お任せします", tag_category_id: cother.id)