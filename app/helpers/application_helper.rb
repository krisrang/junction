module ApplicationHelper
  def title(page_title)
    title = page_title.to_s.blank? ? "" : "#{page_title.to_s} - "
    content_for :disqus_title, page_title.to_s
    content_for :title, title
  end

  def format_tumblr_date(date)
    date.strftime('%B %d, %Y')
  end

  def current_nav(page)
    current_page?(page) ? 'sel' : ''
  end

  def post_slug(post)
    [post_path(post.id), post.slug].join '/'
  end
end
