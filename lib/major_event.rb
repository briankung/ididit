class MajorEvent
  require 'dotiw'

  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::NumberHelper

  def initialize(display_text, event_date)
    @display_text, @event_date = display_text, event_date.to_date
  end

  def to_s current_date
    display(current_date)
  end

  private

  def dotiw(*args)
    distance_of_time_in_words(*args)
  end

  def distance_from current_date
    distance = dotiw(@event_date, current_date, false, except: %i{hours minutes seconds})

    if @event_date.to_date === current_date.to_date
      "today"
    elsif current_date < @event_date
      "in #{distance}"
    else
      "#{distance} ago"
    end
  end

  def display current_date
    "#{@display_text}: #{distance_from(current_date)}"
  end
end
