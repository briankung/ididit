class Done < ApplicationRecord
  scope :yesterday, -> { where date: 1.day.ago }
  scope :today, -> { where date: Date.today }
  scope :text, -> { pluck :text }
end
