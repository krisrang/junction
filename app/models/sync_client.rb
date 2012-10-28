class SyncClient
  def client_name
    self.class.to_s
  end

  private

  def cache(params=nil)
    cache_key = params.blank? ? client_name : "#{client_name}-#{params.to_s}"

    Rails.cache.fetch(cache_key, expires_in: Settings.cache_limit) do
      begin
        fetch params
      rescue
        nil
      end
    end
  end

  def fetch(params=nil)
    raise NotImplementedError
  end

  def fresh_fetch_log(params=nil)
    Rails.logger.info "Fetching fresh #{client_name} result #{params}"
  end
end
