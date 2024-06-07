module DiscoveryEngine
  PAGE_SIZE = 10

  extend self

  def search(query)
    client.search(
      query:,
      page_size: PAGE_SIZE,
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
