module ApplicationHelper
  def format_tumblr_date(date)
    DateTime.strptime(date, '%Y-%m-%d %H:%M:%S %Z').strftime('%B %d, %Y')
  end

  def current_nav(page)
    klass = current_page?(page) ? 'sel' : ''
    "class=\"#{klass}\""
  end

  def post_slug(post)
    [post_path(post.id), post.slug].join '/'
  end
end
