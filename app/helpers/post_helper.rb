module PostHelper
  def title_from_slug(post, prefix=nil)
    prefix = prefix.blank? ? "" : "#{prefix}: "
    prefix + humanize_slug(post.slug)
  end

  def humanize_slug(slug)
    slug.humanize.gsub(/-/, ' ')
  end
end
