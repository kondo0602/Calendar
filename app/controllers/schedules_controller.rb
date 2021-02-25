class SchedulesController < ApplicationController
  before_action :set_all_minutes_instance

  def index
    @schedule = Schedule.new
    # 一覧に表示する予定だけをビューに渡す
    start_date = params.fetch(:start_date, Date.today).to_date
    @schedules = Schedule.where(schedule_date: start_date.beginning_of_week..start_date.end_of_week)
  end

  def create
    @schedule = Schedule.new(schedule_params)
    start_date = @schedule.schedule_date
    @schedules = Schedule.where(schedule_date: start_date.beginning_of_week..start_date.end_of_week)
    if @schedule.save
      redirect_to root_url(start_date: start_date)
    else
      render 'index'
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    start_date = @schedule.schedule_date
    @schedules = Schedule.where(schedule_date: start_date.beginning_of_week..start_date.end_of_week)
    if @schedule.update(schedule_params)
      redirect_to root_url(start_date: start_date)
    else
      render 'edit'
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to root_url
  end

  private

  def schedule_params
    params.require(:schedule).permit(:schedule_date,
                                     :start_time_id,
                                     :end_time_id,
                                     :title,
                                     :color_id)
  end

  def set_all_minutes_instance
    @minutes = Minute.all
  end
end
