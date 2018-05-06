class SearchController < ApplicationController
  before_action :param_is_date?

  def create
    return redirect_to(day_edit_path(Date.current)) unless params[:q]

    if params[:q].start_with?('/') && params[:q].end_with?('/')
      query = [
        "text REGEXP ?", params[:q][1..-2]
      ]
    else
      query = [
        "text like :query OR date = :date",
        {query: "%#{params[:q]}%", date: params[:q]}
      ]
    end

    @dones = Done
      .where(query)
      .order(:date)
      .group_by(&:date)
  end

  private
    def param_is_date?
      Date.parse(params[:q])
      return redirect_to day_edit_path(params[:q])
    rescue
      # if it's not a date, just chill
    end
end
