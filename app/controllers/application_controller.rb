# frozen_string_literal: true

class ApplicationController < ActionController::API
  protect_from_forgery with: :null_session

  def frontend
    render file: "public/index.html", layout: false
  end
end
