# frozen_string_literal: true

class FinalSignup < ApplicationRecord
  belongs_to :student
  belongs_to :final
end
