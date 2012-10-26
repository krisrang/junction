class ModalController < ApplicationController
  layout false

  def lastfm
    client = Lastfm.new
    @user = client.user
    @tracks = client.tracks.track || []

    fresh_when freshness_options(@tracks.max_by(&:date).date)
  end

  def github
    client = Github.new
    @user = client.user
    @repos = client.repos.sort_by(&:pushed_at).reverse

    fresh_when freshness_options(@repos.max_by(&:updated_at).updated_at)
  end

  # TODO: pagination
  def instagram
    client = Instagram.new
    @user = client.user
    @media, @pagination = client.media

    fresh_when freshness_options(@media.max_by(&:date).date)
  end

  def twitter
    @timeline = TwitterClient.new.timeline
    @user = @timeline.first.user if @timeline

    fresh_when freshness_options(@timeline.max_by(&:created_at).created_at)
  end

  def foursquare
    client = Foursquare.new
    @user = client.user
    @checkins = client.checkins

    fresh_when freshness_options(@checkins.max_by(&:date).date)
  end

  def projects
    set_expires
  end

  def contact
    set_expires
  end

  # POST /message
  def contact_send
    email = params[:email]
    message = params[:message]
    Contact.new_message(message, email).deliver
    render text: ""
  end
end
