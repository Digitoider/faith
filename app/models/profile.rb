class Profile < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :recoverable  and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  enum role: [:patient, :doctor]
  after_initialize :set_default_role, :if => :new_record?

  validates :name, :surname, :middlename, :age, presence: true
  validates :age, inclusion: 0..120

  has_many :analyses

  def set_default_role
    self.role ||= :patient
  end
end
