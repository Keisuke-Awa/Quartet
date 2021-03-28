class Form::Meeting < Meeting
  include DatetimeIntegratable

  REGISTRABLE_ATTRIBUTES = %i(
    meet_at_date meet_at_hour meet_at_minute
    people
    place_id
    tag_list
  )

  # DatetimeIntegratableで宣言した、 integrate_datetime_fields関数を利用
  # 下記のように宣言することで、モデル初期化時にpublished_atを
  # published_at_date, published_at_hour, published_at_minute に分解する
  #
  # モデル保存時に、date/hour/minute の3つの変数の値を
  # meet_at に戻す
  integrate_datetime_fields :meet_at

  validates :meet_at_date, presence: true
  validates :meet_at_hour, presence: true
  validates :meet_at_minute, presence: true
end