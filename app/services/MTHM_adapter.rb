# frozen_string_literal: true

require 'MTHM'
class MTHMAdapter
  class << self
    def schedule_lower(rooms, operations)
      # pp operations, rooms
      priorities = Array.new(operations.count, 1)

      operations.sort_by! { |operation| operation.analysis.min_duration }
      operations.reverse!
      weights = []
      operations.each do |operation|
        analysis = operation.analysis
        weights << analysis.min_duration
      end

      rooms.sort_by!(&:capacity)
      capacities = []
      rooms.each do |room|
        capacities << room.capacity
      end

      max_fractional_part_length = find_max_fractional_part_length(weights)
      integerized_weights = integerize weights, max_fractional_part_length
      integerized_capacities = integerize capacities, max_fractional_part_length

      puts 'integerized weights (operations):'
      pp integerized_weights
      puts 'integerized capacities (knapsack):'
      pp integerized_capacities
      arr = []
      operations.each do |op|
        arr << op.analysis.min_duration
      end
      pp 'analysises.min_duration', arr
      # pp arr

      mthm = MTHM.new
      y, c, z = mthm.MTHM(operations.count, rooms.count, priorities, integerized_weights, integerized_capacities)

      pp 'y:', y
      #   y   is a result
      #   y = [1 1 2 2 0 1 1 2 2 0]
      #   y = [1 0]

      # schedule = Array.new(rooms.count, room: Room, operations: [])
      # schedule = Array.new(rooms.count, {})
      # schedule = Array.new(rooms.count)
      schedule = {}
      y.each_with_index do |room_id, index|
        # byebug
        next if room_id.negative?
        schedule[room_id] = {} unless schedule.key?(room_id)
        schedule[room_id][:room] = rooms[room_id]
        schedule[room_id][:operations] = [] unless schedule[room_id].key?(:operations)
        schedule[room_id][:operations] << operations[index]
      end

      # schedule = []
      # y.each_with_index do |room_id, index|
      #   gathered_operations = []
      #   room = nil
      #   y.each_with_index do |room_id1, index1|
      #     if
      #   end
      # end

      # pp "opeartions.count: #{operations.count}"
      # pp 'operations: ', operations
      # floatize schedule
      schedule
    end

    private

    def integerize(array, max_max_fractional_part_length)
      integerized_array = []
      multiplier = find_decimal_multiplier(max_max_fractional_part_length)
      array.each do |elem|
        integerized_array << (elem * multiplier).to_i
      end

      integerized_array
    end

    def find_decimal_multiplier(length)
      multiplier = 1
      length.times { multiplier *= 10 }

      multiplier
    end

    def find_max_fractional_part_length(array)
      max_fractional_part_length = 1
      array.each do |elem|
        fractional_part = elem % 1
        fractional_part_length = fractional_part.to_s.length - 2
        max_fractional_part_length = [max_fractional_part_length, fractional_part_length].max
      end

      max_fractional_part_length
    end
  end
end

# 1.25     2.344
# 1 250    2 344
