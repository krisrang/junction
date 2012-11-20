class Steam < SyncClient
  include HTTParty
  base_uri 'http://steamcommunity.com'

  METHODS = {
    user: "",
    games: "games"
  }

  def user
    cache_get :user
  end

  def games
    cache_get :games
  end

  def sync
    cache_update :user
    cache_update :games
  end

  def valid?(result, params)
    case params
    when :user
      result.is_a?(Hashie::Mash) && result.has_key?("steamID")
    when :games
      result.is_a?(Array) && result[0].is_a?(Hashie::Mash) && result[0].has_key?("appID")
    end
  end

  private

  def ratingParse(rating)
    case rating.to_i
    when 10
      title = "EAGLES SCREAM"
      time = ">= 32 hrs"
    when 9
      title = "Still not 10"
      time = "< 32 hrs"
    when 8
      title = "COBRA KAI!"
      time = "< 28.8 hrs"
    when 7
      title = "Wax on, Wax off"
      time = "< 25.6 hrs"
    when 6
      title = "Oooh! Shiny!"
      time = "< 22.4 hrs"
    when 5
      title = "Halfway Cool"
      time = "< 19.2 hrs"
    when 4
      title = "Master of Nothing"
      time = "< 16 hrs"
    when 3
      title = "Shooting Blanks"
      time = "< 12.8 hrs"
    when 2
      title = "Nearly Lifeless"
      time = "< 9.6 hrs"
    when 1
      title = "El Terrible!"
      time = "< 6.4 hrs"
    else
      title = "Teh Suck"
      time = "< 3.2 hrs"
    end

    Hashie::Mash.new({rating: rating, title: title, time: time})
  end

  def fetch(method=nil)
    path = METHODS[method]
    r = query path

    hash = r.response.code.to_s == "200" && r.parsed_response.is_a?(Hash) ?
        r.parsed_response :
        {"profile" => {}}

    if method == :user
      Hashie::Mash.new(hash["profile"]).tap do |user|
        user.url = "http://steamcommunity.com/id/#{user.steamID}/"
        user.joined = Date.parse(user.memberSince)
        user.rating = ratingParse(user.steamRating.to_f)
      end
    elsif method == :games
      games = hash["gamesList"]["games"]["game"].map do |game|
        Hashie::Mash.new(game).tap do |g|
          g.link = g.statsLink || g.storeLink
          g.hoursOnRecord = g.hoursOnRecord.to_f || 0
          g.hoursLast2Weeks = g.hoursLast2Weeks.to_f || 0
        end
      end

      recent = games.select { |g| g.hoursLast2Weeks > 0.0 }
      old = games.select { |g| g.hoursLast2Weeks == 0 }

      recent.sort_by(&:hoursOnRecord).reverse.concat old.sort_by(&:hoursOnRecord).reverse
    end
  end

  def query(method)
    self.class.get("/id/kriszor/#{method}?xml=1")
  end
end
