class Form::Meeting < Meeting
  include DatetimeIntegratable

  REGISTRABLE_ATTRIBUTES = %i(
    meet_at_date meet_at_hour meet_at_minute
    people
    place_id
    tag_list
    detail
  )

  # DatetimeIntegratableで宣言した、 integrate_datetime_fields関数を利用
  # 下記のように宣言することで、モデル初期化時にpublished_atを
  # published_at_date, published_at_hour, published_at_minute に分解する
  #
  # モデル保存時に、date/hour/minute の3つの変数の値を
  # meet_at に戻す
  integrate_datetime_fields :meet_at

  validates :meet_at, presence: true
  validates :people, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :place_id, presence: true
  validates :detail, length: { maximum: 800 }

  validate :valid_meet_at?

  def valid_meet_at?
    return if meet_at > DateTime.now && meet_at < DateTime.now + 1.month
    errors.add(:base, "１ヶ月以内の日時を入力してください。")
  end
end