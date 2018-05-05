class Done < ApplicationRecord
  scope :yesterday, -> { where date: 1.day.ago }
  scope :today, -> { where date: Date.today }
  scope :on_date, ->(date) { where date: date }
  scope :text, -> { pluck :text }
end
