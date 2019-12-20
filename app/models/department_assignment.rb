# This model is for convenient importing from school's SQL server
class DepartmentAssignment < ApplicationRecord
  belongs_to :teacher
  belongs_to :department
end
