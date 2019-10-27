# frozen_string_literal: true

class Final < ApplicationRecord
  belongs_to :course

  has_many :final_signups
  has_many :students, through: :final_signups
end
