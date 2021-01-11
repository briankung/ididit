require 'major_event'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :major_events

  def major_events
    @major_events = Rails.application.credentials.major_events.map { |event| MajorEvent.new(*event) }

    today = MajorEvent.new("Today", Time.now)
    today.instance_eval do
      def to_s current_date
        @event_date, current_date = current_date, @event_date
        "#{distance_from(current_date)}\n"
      end
    end

    @major_events.unshift(today)
  end
end
