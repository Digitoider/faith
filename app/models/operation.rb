class Operation < ApplicationRecord
  belongs_to :room, optional: true
  belongs_to :analysis
end
