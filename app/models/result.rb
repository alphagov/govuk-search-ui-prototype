class Result
  def initialize(discovery_engine_result)
    @discovery_engine_result = discovery_engine_result
  end

  delegate :title, :link, to: :struct_data

  def url
    link.start_with?("http") ? link : "https://www.gov.uk#{link}"
  end

private

  attr_reader :discovery_engine_result

  def struct_data
    @struct_data ||= OpenStruct.new(discovery_engine_result.document.struct_data.to_h)
  end
end