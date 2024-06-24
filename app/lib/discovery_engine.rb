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

  def summary(query, type:, prompt_preamble:, summary_result_count:, ignore_adversarial:, ignore_non_summary_seeking:, use_preview_model:)
    content_search_spec = if type == "summary"
                            {
                              extractive_content_spec: {
                                max_extractive_answer_count: 1,
                              },
                              summary_spec: {
                                summary_result_count:,
                                ignore_adversarial_query: ignore_adversarial,
                                ignore_non_summary_seeking_query: ignore_non_summary_seeking,
                                model_spec: { version: use_preview_model ? "preview" : "stable" },
                                model_prompt_spec: { preamble: prompt_preamble }.compact,
                              },
                            }
                          elsif type == "snippets"
                            {
                              snippet_spec: {
                                return_snippet: true,
                              },
                            }
                          end

    search_service.search(
      query:,
      page_size: PAGE_SIZE,
      content_search_spec: content_search_spec&.compact,
      serving_config:,
    ).response
  end

  def complete(query, model: "document-completable", include_tail: true)
    completion_service.complete_query(
      query:,
      query_model: model,
      include_tail_suggestions: include_tail,
      data_store:,
    ).query_suggestions.map(&:suggestion)
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
