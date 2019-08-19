module ApplicationHelper
  def review_time time
    time.strftime("%b %d, %Y, %H:%M")
  end
end
