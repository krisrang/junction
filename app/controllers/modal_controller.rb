class ModalController < ApplicationController
  #before_filter :set_expires

  def lastfm
    client = Lastfm.new
    @user = client.user
    @tracks = client.tracks.track || []
    render partial: 'lastfm'
  end

  def github
    client = Github.new
    @user = client.user
    @repos = client.repos
    render partial: 'github'
  end

  # TODO: pagination
  def instagram
    client = Instagram.new
    @user = client.user
    @media, @pagination = client.media
    render partial: 'instagram'
  end

  def twitter
    @timeline = TwitterClient.timeline
    @user = @timeline.first.user if @timeline
    render partial: 'twitter'
  end

  def foursquare
    client = Foursquare.new
    @user = client.user
    @checkins = client.checkins.items
    render partial: 'foursquare'
  end

  def projects
    render partial: 'projects'
  end

  def contact
    render partial: 'contact'
  end

  # POST /message
  def contact_send
    email = params[:email]
    message = params[:message]
    Contact.new_message(message, email).deliver
    render text: ""
  end
end
