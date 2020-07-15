module ApplicationHelper
  require 'dotiw'

  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::NumberHelper

  def dotiw(*args)
    distance_of_time_in_words(*args)
  end

  def show_ages date
    <<~AGES.strip
      Avery's age: #{dotiw(@birthdays[:avery], date, false, except: %i{hours minutes seconds})}
      Dynamite's age: #{dotiw(@birthdays[:dynamite], date, false, except: %i{hours minutes seconds})}
    AGES
  end
end
