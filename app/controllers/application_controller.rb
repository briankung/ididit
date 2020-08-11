require 'major_event'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :major_events

  def major_events
    @major_events = Rails.application.credentials.major_events.map { |event| MajorEvent.new(*event) }
  end
end
