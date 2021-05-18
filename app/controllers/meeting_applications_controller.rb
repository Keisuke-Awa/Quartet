class MeetingApplicationsController < ApplicationController

  before_action :set_meeting, only: %i[create index show]
  before_action :ban_appying_to_same_sex, only: :create

  def create
    @user = @meeting.planning_user
    ActiveRecord::Base.transaction do
      @meeting_application = MeetingApplication.create!(meeting_application_params)
      NewArrival.create!(user: @user, model: "MeetingApplication", record_id: @meeting_application.id)
    end
    @user = @meeting.planning_user
    respond_to do |format|
      format.html { redirect_back(fallback_location: @meeting, notice: "申請が完了しました。") }
      format.js { render ajax_redirect_to(meeting_path(@meeting)), flash[:notice] = "申請が完了しました。" }
    end
  rescue ActiveRecord::RecodeInvalid
    respond_to do |format|
      format.js { render ajax_redirect_to(meeting_path(@meeting)), flash[:error] = "申請に失敗しました。" }
    end
  end

  def destroy
    @meeting = MeetingApplication.find(params[:id]).meeting
    @user = @meeting.planning_user
    current_user.unapply_meeting(@meeting)
    respond_to do |format|
      format.html { redirect_back(fallback_location: @meeting, notice: "申請を取り消しました。") }
      format.js #{ render ajax_redirect_to(meeting_path(@meeting)), flash[:notice] = "申請を取り消しました。" }
    end
  end

  def index
    @meeting_applications = @meeting.meeting_applications.eager_load(applicant: {avatar_attachment: :blob}).page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @meeting_application = MeetingApplication.find(params[:id])
    @partner = @meeting_application.applicant
    @message_room = nil
    Array(current_user.message_rooms).each do |cmr|
      Array(@partner.message_rooms).each do |ncmr|
        @message_room = ncmr if cmr == ncmr
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end

  def ban_appying_to_same_sex
    return if @meeting.planning_user.sex != current_user.sex
    respond_to do |format|
      format.html { redirect_back(fallback_location: @meeting, flash: {error: "このプランには申請できません。"}) }
      format.js { render ajax_redirect_to(meeting_path(@meeting)), flash[:error] = "このプランには申請できません。" }
    end
  end

  def meeting_application_params
    params.require(:meeting_application).permit(:detail).merge(meeting_id: params[:meeting_id], applicant_id: current_user.id)
  end

end
