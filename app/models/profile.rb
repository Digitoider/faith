class Profile < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :recoverable  and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  
  enum role: [:patient, :doctor]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :patient
  end
end
