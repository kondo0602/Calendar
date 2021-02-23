class SchedulesController < ApplicationController
  before_action :set_all_schedules_instance, only: %i[index create]
  before_action :set_params_schedules_instance, only: %i[edit update]
  before_action :set_all_minutes_instance, only: %i[index create edit update destroy]

  def index
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      redirect_to root_url
    else
      render 'index'
    end
  end

  def edit; end

  def update
    if @schedule.update(schedule_params)
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
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

  def set_all_schedules_instance
    @schedules = Schedule.all
  end

  def set_params_schedules_instance
    @schedule = Schedule.find(params[:id])
  end

  def set_all_minutes_instance
    @minutes = Minute.all
  end
end
