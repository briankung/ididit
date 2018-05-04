class DaysController < ApplicationController
  def edit
    @dones = Done.where(date: params[:date]).pluck(:text).join("\n")
  end
end
