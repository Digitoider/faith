require 'MTHM_adapter'
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

  def generate
    errors = validate_data

    return render json: {errors: errors} if errors.any?
    # TODO: Generate Schedule
    rooms = populate_rooms_from_params
    operations = Operation.where(is_operated: false).where(assigned: false)
    operations = operations.select do |operation|
      operation.analysis.operation_required
    end
    # pp operations, rooms
    schedule = ::MTHMAdapter.schedule_lower(rooms, operations)

    # 5.times {puts}
    # pp 'schedule:', schedule

    # byebug

    schedule.each do |elem|
      elem[1][:room].save
      time = Date.parse(params[:at]).beginning_of_day + 9.hours
      elem[1][:operations].each do |operation|
        operation.starts_at = time
        time += operation.analysis.min_duration.hours
        operation.ends_at = time
        operation.room = elem[1][:room]
        operation_day = OperationDay.new(at:  Date.parse(params[:at]))
        operation_day.rooms << elem[1][:room]
        # elem[1][:room].operation_day = operation_day
        operation.assigned = true
        operation.save
      end
    end


    # TODO: Save schedule
    # TODO: Respond with success (and maybe a link to generated schedule)
  end

  protected

  def populate_rooms_from_params
    rooms = []
    params[:rooms].each do |room|
      room = room[1].to_hash
      name = room['name']
      capacity = room['capacity'].to_f
      info = room['info']
      rooms << Room.new(name: name, capacity: capacity, info: info)
    end

    rooms
  end

  def validate_data
    errors = []
    errors.push "Operation date shouldn't be blank" if params[:at].blank?

    unless params[:at].blank?
      begin
        at = Date.parse(params[:at])
      rescue ArgumentError
        errors.push "Operation date has invalid format"
      end
    end
    
    unless at.nil?
      errors.push "The date you've picked has been already taken. Please, pick another operation date" if OperationDay.where(at: at).exists?
    end

    params.require(:rooms).permit!
    rooms = params[:rooms]
    rooms.to_h.each do |room|
      room = room[1]
      p room['name']
      errors.push "Name shouldn't be empty for ROOM #{room['id']}" if room['name'].strip.empty?

      if room['capacity'] !~ /^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/
        errors.push "Capacity must be of type float! (ROOM #{room['id']})"
      else
        capacity = room['capacity'].to_f
        errors.push "Capacity shouldn't be less than 0 or greater than 12 (ROOM #{room['id']})" if capacity < 0 || capacity > 12
      end
    end

    errors
  end


end
