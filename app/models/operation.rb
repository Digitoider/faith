class Operation < ApplicationRecord
  belongs_to :operation_day, optional: true
  belongs_to :analysis
end
