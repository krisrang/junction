class ModalController < ApplicationController
  layout false

  def lastfm
    client = Lastfm.new
    @user = client.user
    @tracks = client.tracks.track || []
  end

  def github
    client = Github.new
    @user = client.user
    @repos = client.repos.sort_by(&:pushed_at).reverse
  end

  # TODO: pagination
  def instagram
    client = Instagram.new
    @user = client.user
    @media, @pagination = client.media
  end

  def twitter
    @timeline = TwitterClient.new.timeline
    @user = @timeline.first.user if @timeline
  end

  def foursquare
    client = Foursquare.new
    @user = client.user
    @checkins = client.checkins
  end

  def projects
  end

  def contact
  end

  # POST /message
  def contact_send
    email = params[:email]
    message = params[:message]
    Contact.new_message(message, email).deliver
    render text: ""
  end
end
