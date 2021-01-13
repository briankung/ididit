require 'major_event'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :major_events

  def major_events
    @major_events = Rails.application.credentials.major_events.map { |event| MajorEvent.new(*event) }

    today = MajorEvent.new("Today", Time.now)
    today.instance_eval do
      def to_s current_date
        distance = dotiw(current_date, @event_date, false, except: %i{hours minutes seconds})

        if @event_date.to_date === current_date.to_date
          "today"
        elsif @event_date < current_date
          "in #{distance}"
        else
          "#{distance} ago"
        end
      end
    end

    @major_events.unshift(today)
  end
end
