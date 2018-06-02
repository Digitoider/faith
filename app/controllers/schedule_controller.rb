class ScheduleController < ApplicationController

  def new
    @operation_day = OperationDay.new
    render
  end

  def create

  end

end
