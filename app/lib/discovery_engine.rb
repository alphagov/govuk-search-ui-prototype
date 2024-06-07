module DiscoveryEngine
  extend self

  def search(query)
    client.search(
      query:,
      serving_config:,
    ).response
  end

private

  def client
    @client ||= ::Google::Cloud::DiscoveryEngine.search_service(version: :v1)
  end

  def serving_config
    ENV.fetch("DISCOVERY_ENGINE_SERVING_CONFIG")
  end
end
