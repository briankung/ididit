class SearchController < ApplicationController
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

    if @dones.count > 100
      @read_only = true
    end
  end
end
