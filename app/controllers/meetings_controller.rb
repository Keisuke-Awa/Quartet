class MeetingsController < ApplicationController
  require "date"

  before_action :initialize_search_form, only: %i[index search]

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
    @meeting = Meeting.find(params[:id])
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
    search_result
    respond_to do |format|
      format.html
      format.js
    end
  end

  def search
    search_result
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

  def search_result
    @q = Meeting.ransack(params[:q])
    @meetings = @q.result(distinct: true).where.not(planning_user_id: current_user.id).where(meet_at: DateTime.now..Float::INFINITY)
            .where(appointment_id: nil).eager_load(:place).includes(planning_user: {avatar_attachment: :blob}).page(params[:page]).per(10)
  end

  def initialize_search_form
    @places = Place.all
    @week = [(0..6).to_a.map {|i| Date.today + i.days }, (7..13).to_a.map {|i| Date.today + i.days },
                  (14..20).to_a.map {|i| Date.today + i.days }, (21..27).to_a.map {|i| Date.today + i.days }]
  end
end
