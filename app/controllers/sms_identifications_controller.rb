class SmsIdentificationsController < ApplicationController
  
  require "securerandom"

  skip_before_action :authenticate_user_with_ajax!

  def input_code
  end

  def send_code
    phone_number = PhonyRails.normalize_number(params[:phone_number], country_code:'JP')
    User.find_by(phone_number: phone_number)
    if User.find_by(phone_number: phone_number)
      flash.now[:alert] = 'すでに登録済みです'
      render :input_code
    else
      session[:auth_code] = random_number_generator(6)
      session[:phone_number] = phone_number
      begin
        client = Twilio::REST::Client.new
        result = client.messages.create(
          from: Rails.application.credentials.twilio[:TWILIO_PHONE_NUMBER],
          to: session[:phone_number],
          body: "認証番号は#{session[:auth_code]}です。"
        )
        render template: 'sms_identifications/send_code'
      rescue Twilio::REST::RestError => e
        @messages = "エラーコード[#{e.code}] ：” #{e.message}”"
        redirect_to root_path
      end
    end
  end

  def check_code
    if params[:auth_code].present?
    else
      flash.now[:alert] = '認証番号を入力してください'
      render :send_code and return
    end

    if session[:auth_code] == params[:auth_code]
      redirect_to new_user_registration_path
    else
      flash.now[:alert] = '認証番号が一致しません'
      render :send_code
    end
  end

  private

  def random_number_generator(n)
    ''.tap { |s| n.times { s << rand(0..9).to_s } }
  end
end
