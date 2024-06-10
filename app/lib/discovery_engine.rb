module DiscoveryEngine
  PAGE_SIZE = 10

  extend self

  def search(query)
    search_service.search(
      query:,
      page_size: PAGE_SIZE,
      serving_config:,
    ).response
  end

  def complete(query)
    completion_service.complete_query(
      query:,
      data_store:,
    )
  end

private

  def search_service
    @search_service ||= ::Google::Cloud::DiscoveryEngine.search_service(version: :v1)
  end

  def completion_service
    @completion_service ||= ::Google::Cloud::DiscoveryEngine.completion_service(version: :v1)
  end

  def serving_config
    ENV.fetch("DISCOVERY_ENGINE_SERVING_CONFIG")
  end

  def data_store
    ENV.fetch("DISCOVERY_ENGINE_DATASTORE")
  end
end
