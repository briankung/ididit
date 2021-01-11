module DonesHelper
  def param_date
    Time.strptime(params[:q], DATE_FORMAT)
  end

  def query_path date
    "?q=#{date}"
  end

  def time_from_now date

    if date > Time.today
      "#{distance_of_time_in_words(Time.now, date)} from now"
    elsif date == Time.today
      "Today"
    else
      "#{distance_of_time_in_words(Time.now, date + 12.hours)} ago"
    end
  end
end
