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

annual_income = ['200万円未満', '200万円以上〜400万円未満', '400万円以上〜600万円未満', '600万円以上〜800万円未満',
  '800万円以上〜1000万円未満', '1000万円以上〜1500万円未満', '1500万円以上〜2000万円未満', '2000万円以上〜3000万円未満', '3000万円以上']

smoking_status = ['吸わない', '吸う', '吸う（電子タバコ）', '時々吸う', '非喫煙者の前では吸わない']

pref.each { |p| PrefectureMst.create!(prefecture_name: p)}
occupation.each { |op| OccupationMst.create!(occupation_name: op)}
educational_bg.each { |eb| EducationalBgMst.create!(ebg_name: eb)}
annual_income.each { |ai| AnnualIncomeMst.create!(income_range: ai)}
smoking_status.each { |st| SmokingMst.create!(smoking_status: st)}



def rand_time(from, to)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

300.times do |n|
  name = Faker::Name.name
  email = "rails#{n+1}@sample.com"
  password = "password"
  birth_date = Faker::Date.birthday(min_age: 20, max_age: 40)
  if n < 150
    sex = '1'
  else
    sex = '2'
  end
  User.create!(name: name, email: email, password: password, birth_date: birth_date, sex: sex, residence_id: 13)
end

Place.create!(name: "新宿", prefecture_id: 13)
Place.create!(name: "池袋", prefecture_id: 13) 
Place.create!(name: "渋谷", prefecture_id: 13)

def rand_in_range(from, to)
  rand * (to - from) + from
end


300.times do |n|
  detail = Faker::Lorem.sentence
  meet_at = rand_time(Time.now, 7.days.since)
  people = rand(6) + 1
  place_id = rand(Place.count) + 1
  user = User.find(n + 1)
  Meeting.create!(detail: detail, meet_at: meet_at, people: people, place_id: place_id, planning_user_id: user.id)
end

cmeal = MealTypeCategory.create!(name: "料理")
catmosphere = MealTypeCategory.create!(name: "雰囲気")
cother = MealTypeCategory.create!(name: "その他")

MealTypeTag.create!(name: "中華料理", category_id: cmeal.id)
MealTypeTag.create!(name: "和食", category_id: cmeal.id)
MealTypeTag.create!(name: "イタリアン", category_id: cmeal.id)

MealTypeTag.create!(name: "にぎやか", category_id: catmosphere.id)
MealTypeTag.create!(name: "落ち着いた", category_id: catmosphere.id)
MealTypeTag.create!(name: "夜景がきれい", category_id: catmosphere.id)

MealTypeTag.create!(name: "お任せします", category_id: cother.id)