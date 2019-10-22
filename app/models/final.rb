class Final < ApplicationRecord
  belongs_to :course

  has_many :signups
  has_many :students, through: :signups
end
