# frozen_string_literal: true

class FinalSignup < ApplicationRecord
  belongs_to :student, class_name: :user
  belongs_to :final
end
