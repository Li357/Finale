# frozen_string_literal: true

class Final < ApplicationRecord
  belongs_to :course
  belongs_to :supervisor, class_name: "Teacher", foreign_key: :teacher_id, primary_key: :user_id, inverse_of: :finals
  has_many :final_signups
  has_many :students, through: :final_signups
end
