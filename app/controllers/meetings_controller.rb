class MeetingsController < ApplicationController

  require "date"

  before_action :set_meeting, only: :show
  before_action :restrict_by_sex, only: :show
  before_action :initialize_search_form, only: %i[index search]
  before_action :set_ransack, only: %i[index search]

  def new
    @meeting = Meeting.new
    @places = Place.all
    @tag_category = TagCategory.all.includes([:tags])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @user = @meeting.planning_user
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @meeting = Meeting.create(meeting_params)
    redirect_to home_user_path(current_user.id)
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

  # def index_meeting_application
  #   @meeting = Meeting.find(params[:id])
  #   @meeting_applications = @meeting.meeting_applications
  # end

  private

  def meeting_params
    params.require(:meeting).permit(:place_id, :people, :meet_at, :tag_list).merge(planning_user_id: current_user.id)
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
    four_weeks = [0..6, 7..13, 14..20, 21..27]
    @week = four_weeks.map { |week| week.to_a.map {|i| Date.today + i.days } }
  end

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def restrict_by_sex
    return unless @meeting.planning_user.sex == current_user.sex
    respond_to do |format|
      format.html { redirect_to home_user_path(current_user), flash: {error: "該当ページにはアクセスできません。"} }
      format.js { render ajax_redirect_to(home_user_path(current_user)), flash[:error] = "該当ページにはアクセスできません。" }
    end
  end

end
