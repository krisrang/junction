module PostHelper
  def title_from_slug(post, prefix=nil)
    prefix = prefix.blank? ? "" : "#{prefix}: "
    prefix + humanize_slug(post.slug)
  end

  def humanize_slug(slug)
    slug.humanize.gsub(/-/, ' ')
  end

  def format_tumblr_date(date)
    date.strftime('%B %d, %Y')
  end

  def post_slug(post)
    [post_path(post.id), post.slug].join '/'
  end
end
