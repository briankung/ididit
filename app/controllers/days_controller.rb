class DaysController < ApplicationController
  before_action :clamp_date

  def edit
    @dones = Done.where(date: params[:date]).pluck(:text).join("\n")
  end

  private

  def stupid_american_date
    @match = params[:date].match /^(?<MM>\d{2})-(?<DD>\d{2})-(?<YYYY>\d{4})$/
  end

  def reformatted_date
    @match.values_at(:YYYY, :MM, :DD).join('-')
  end

  def clamp_date
    return redirect_to day_edit_path(reformatted_date) if stupid_american_date
    Time.strptime(params[:date], "%Y-%m-%d")
  rescue ArgumentError
    redirect_to day_edit_path(Time.current.strftime(DATE_FORMAT))
  end
end
