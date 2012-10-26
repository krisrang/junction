class SyncClient
  class_attribute :default_options
  self.default_options = {
    client_name: "Base"
  }

  class << self
    def client_name(name)
      self.default_options[:client_name] = name
    end
  end

  def client_name
    self.default_options[:client_name]
  end

  private

  def cache(params=nil)
    cache_key = params.blank? ? "" : params.to_s
    Rails.cache.fetch("#{client_name}-#{params}", expires_in: Settings.cache_limit) do
      fetch params
    end
  end

  def fetch(params=nil)
    raise NotImplementedError
  end

  def fresh_fetch_log(params=nil)
    Rails.logger.info "Fetching fresh #{client_name} result #{params}"
  end
end
