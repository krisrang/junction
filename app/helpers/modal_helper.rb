module ModalHelper
  include Twitter::Autolink

  def foursquare_venue_image(venue)
    category =  venue.categories[0]
    category.icon if category
  end

  def twitter_linkify(text)
    auto_link(text)
  end
end
