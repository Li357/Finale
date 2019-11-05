# frozen_string_literal: true

module Helpers::Authorization
  def can_view_final!(user, final)
    associated_with_course = user.courses.any? { |course| course.id == final.course.id }
    if associated_with_course
      final
    else
      raise Errors::NotAuthorizedError
    end
  end
end
