class MeetingsController < ApplicationController

  def new
    @meeting = Meeting.new
    @places = Place.all
  end

  def show
    @meeting = Meeting.find(params[:id])
  end

  def create
    @meeting = Meeting.create(meeting_params)
    redirect_to home_user_path(current_user.id)
  end

  def destroy
  end

  def index
    @q = Meeting.ransack(params[:q])
    @meetings = @q.result(distinct: true).where.not(planning_user_id: current_user.id).eager_load([{planning_user: :avatar_attachment}, :place]).page(params[:page]).per(10)
    @places = Place.all
    # @week = (0..6).to_a.map {|i| (Time.now + i.days).strftime("%m/%d")}
  end

  # def index_meeting_application
  #   @meeting = Meeting.find(params[:id])
  #   @meeting_applications = @meeting.meeting_applications
  # end

  private

  def meeting_params
    params.require(:meeting).permit(:place_id, :people, :meet_at).merge(planning_user_id: current_user.id)
  end

  def search_params
    params.require(:q).permit(:meet_at_gteq, :meet_at_lteq, :place_id_eq, :people_eq)
  end
end
