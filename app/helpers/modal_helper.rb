module ModalHelper
  include Twitter::Autolink

  def lastfm_date(date)
    date.to_s :long_ordinal
  end

  def foursquare_time(time)
    Time.at(time.to_i).to_s :long_ordinal
  end

  def foursquare_venue_image(venue)
    category =  venue.categories[0]
    category.icon if category
  end

  def twitter_linkify(text)
    auto_link(text)
  end
end
