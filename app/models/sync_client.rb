class SyncClient
  def client_name
    self.class.to_s
  end

  def valid?(response=nil, params=nil)
    false
  end

  def sync
    raise NotImplementedError
  end

  private

  def cache_get(params=nil)
    result = Rails.cache.read(cache_key(params))
  end

  def cache_update(params=nil)
    fresh_fetch_log params

    response = fetch(params) rescue nil

    if valid?(response, params)
      Rails.cache.write(cache_key(params), response)
    else
      fresh_fetch_failed_log params
    end
  end

  def fetch(params=nil)
    raise NotImplementedError
  end

  def cache_key(params=nil)
    params.blank? ? client_name : "#{client_name}-#{params.to_s}"
  end

  def fresh_fetch_log(params=nil)
    Rails.logger.info "Fetching fresh #{client_name} result for #{params}"
  end

  def fresh_fetch_failed_log(params=nil)
    Rails.logger.warn "Fetching fresh #{client_name} result failed for #{params}, keeping old cache"
  end
end
