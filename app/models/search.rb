class Search
  def initialize(discovery_engine_response)
    @discovery_engine_response = discovery_engine_response
  end

  delegate :attribution_token, :corrected_query, :total_size, to: :discovery_engine_response

  def results
    discovery_engine_response.results.map { Result.new(_1) }
  end

  def corrected_query?
    corrected_query.present?
  end

private

  attr_reader :discovery_engine_response
end
