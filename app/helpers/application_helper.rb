module ApplicationHelper
  def show_distances_of_time date
    @major_events.map {|event| event.to_s(date)}.join("\n")
  end
end
