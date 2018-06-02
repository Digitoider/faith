class ScheduleController < ApplicationController

  def new
    @operation_day = OperationDay.new
    @operations = Operation.where(is_operated: false)
    @profiles_fio = @operations.map do |op|
      p = op.analysis.profile
      [p.surname, p.name, p.middlename].join ' '
    end
    render
  end

  def create

  end

end
