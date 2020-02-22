class AddDefaultTimestamp < ActiveRecord::Migration[6.0]
  def change
    [
      :users, :admins, :roles, :students, :teachers,
      :department_assignments, :departments,
      :courses, :student_course_registrations, :teacher_course_registrations,
      :finals, :student_final_signups, :teacher_final_assignments,
    ].each do |table|
      change_column_null table, :created_at, true
      change_column_null table, :updated_at, true

      change_column_default table, :created_at, -> { 'CURRENT_TIMESTAMP' }
      change_column_default table, :updated_at, -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
