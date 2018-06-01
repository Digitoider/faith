class Analysis < ApplicationRecord
  belongs_to :profile
  belongs_to :operation_day, optional: true
  has_one :operation

  validates :profile_id, :analysis, :received_at, presence: true
  validate :operation_required_validator

  protected

  def operation_required_validator
    if operation_required
      errors.add :min_duration, "can't be blank if operation is required" if min_duration.blank?
      errors.add :max_duration, "can't be blank if operation is required" if max_duration.blank?

      validates_numericality_of :min_duration
      validates_numericality_of :min_duration

      errors.add :min_duration, "can't be less than 0" if min_duration.to_f < 0
      errors.add :max_duration, "can't be less than 0" if max_duration.to_f < 0

      errors.add :min_duration, "can't be greater than 8" if min_duration.to_f > 8
      errors.add :max_duration, "can't be greater than 8" if max_duration.to_f > 8

      errors.add :max_duration, "can't be greater than 8" if max_duration.to_f > 8
      errors.add :min_duration, "can't be grater than Max duration" if min_duration.to_f > max_duration.to_f
    end
    # errors.count > 0 ? false: true
  end

end
