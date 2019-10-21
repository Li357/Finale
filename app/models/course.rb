class Course < ApplicationRecord
  has_many :course_registration
  has_many :users, through: :course_registration
  has_many :finals
end
