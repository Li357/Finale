# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Cookies
  protect_from_forgery with: :null_session

  def frontend
    render file: "public/index.html", layout: false
  end
end
