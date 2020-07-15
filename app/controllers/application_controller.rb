class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :birthdays

  def birthdays
    @birthdays = Rails.application.credentials.birthdays
  end
end
