class Summary
  def initialize(discovery_engine_response)
    @discovery_engine_response = discovery_engine_response
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

private

  attr_reader :discovery_engine_response
end
