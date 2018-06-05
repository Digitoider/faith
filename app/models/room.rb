class Room < ApplicationRecord
  has_many :operations
  belongs_to :operation_day
end
