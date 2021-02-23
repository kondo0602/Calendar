class SchedulesController < ApplicationController
  def index
    @schedule = Schedule.new
    @schedules = Schedule.all
    @minutes = Minute.all
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedules = Schedule.all
    @minutes = Minute.all
    if @schedule.save
      redirect_to root_url
    else
      render 'index'
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
    @minutes = Minute.all
  end

  def update
    @schedule = Schedule.find(params[:id])
    @minutes = Minute.all
    if @schedule.update(schedule_params)
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    Schedule.find(params[:id]).destroy
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
end
