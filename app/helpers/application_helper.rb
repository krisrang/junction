module ApplicationHelper
  def title(page_title)
    title = page_title.to_s.blank? ? "" : "#{page_title.to_s} - "
    content_for :disqus_title, page_title.to_s
    content_for :title, title
  end

  def current_nav(page)
    current_page?(page) ? 'sel' : ''
  end
end
