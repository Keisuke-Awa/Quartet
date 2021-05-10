class MeetingsController < ApplicationController

  require "date"

  before_action :set_meeting, only: :show
  before_action :initialize_search_form, only: %i[index search]
  before_action :set_ransack, only: %i[index search]
  before_action :initialize_new_form, only: %i[new create]
  before_action :set_recommend_meetings, only: %i[new create]

  def new
    @meeting = Form::Meeting.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    return unless @meeting.planning_user == current_user || restrict_by_sex
    @has_appointment = false
    if @meeting.appointment && @meeting.appointment.users.find_by(id: current_user.id)
      @user = @meeting.appointment.users.select_partner(current_user)
      Array(current_user.message_rooms).each do |cmr|
        Array(@puser.message_rooms).each do |ncmr|
          @message_room ||= ncmr if cmr == ncmr
        end
      end
      @has_appointment = true
    else
      @user = @meeting.planning_user
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @meeting = Form::Meeting.new(meeting_params)
    if @meeting.save
      redirect_to home_user_path(current_user.id)
    else
      respond_to do |format|
        format.js { render 'new.js.erb' }
      end
    end
  end

  def destroy
  end

  def index
    @meetings = Meeting.display_list(current_user, params[:page])
    if user_signed_in?
      respond_to do |format|
        format.html
        format.js
      end
    else
      respond_to do |format|
        format.js { render ajax_redirect_to(new_user_session_path) }
      end
    end
  end

  def search
    @meetings = @q.result(distinct: true).display_list(current_user, params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def meeting_params
    params.require(:form_meeting).permit(Form::Meeting::REGISTRABLE_ATTRIBUTES).merge(planning_user_id: current_user.id)
  end

  def search_params
    params.require(:q).permit(:meet_at_equals_date, :place_id_eq, :people_eq)
  end

  # def self.search_result
  #   @q = self.ransack(params[:q])
  #   @meetings = @q.result(distinct: true).where(meet_at: DateTime.now..Float::INFINITY).where(appointment_id: nil)
  #   .eager_load(planning_user: {avatar_attachment: :blob}).where.not(planning_user_id: current_user.id)
  #   .where.not(users: {sex: current_user.sex}).eager_load(:place).page(params[:page]).per(30)
  # end

  def set_ransack
    @q = Meeting.ransack(params[:q])
  end
  

  def initialize_search_form
    @places = Place.all
    @people = { "2 on 2": 2, "3 on 3": 3, "4 on 4": 4 }
    @week = initialize_four_weeks
  end

  def initialize_new_form
    @people = { "2 on 2": 2, "3 on 3": 3, "4 on 4": 4 }
    @places = Place.all
    @date_and_time = initialize_datetime
    @tag_category = TagCategory.all.includes([:tags])
  end

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def restrict_by_sex
    return true unless @meeting.planning_user.sex == current_user.sex
    respond_to do |format|
      format.html { redirect_to home_user_path(current_user), flash: {error: "該当ページにはアクセスできません。"} }
      format.js { render ajax_redirect_to(home_user_path(current_user)), flash[:error] = "該当ページにはアクセスできません。" }
    end
  end

  def set_recommend_meetings
    @recommend_meetings = Meeting.recommend_list(current_user).order("RAND()").limit(4)
  end

end
