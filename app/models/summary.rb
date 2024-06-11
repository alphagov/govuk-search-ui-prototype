class Summary
  def initialize(discovery_engine_response, summary_result_count:)
    @discovery_engine_response = discovery_engine_response
    @summary_result_count = summary_result_count
  end

  delegate :attribution_token, to: :discovery_engine_response

  def content
    discovery_engine_response.summary.summary_text
  end

  def content?
    content.present?
  end

  def skipped?
    skipped_reasons.any?
  end

  def skipped_reasons
    discovery_engine_response.summary.summary_skipped_reasons || []
  end

  def safety_attributes?
    safety_attributes.present?
  end

  def safety_attributes
    attrs = discovery_engine_response.summary.safety_attributes
    return unless attrs

    attrs.categories.zip(attrs.scores).to_h
  end

  def results_considered
    discovery_engine_response.results.first(summary_result_count).map { Result.new(_1) }
  end

private

  attr_reader :discovery_engine_response, :summary_result_count
end
