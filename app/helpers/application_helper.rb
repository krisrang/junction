module ApplicationHelper
  def format_tumblr_date(date)
    DateTime.strptime(date, '%Y-%m-%d %H:%M:%S %Z').strftime('%B %d, %Y')
  end
end
