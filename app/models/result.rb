class Result
  def initialize(discovery_engine_result, displayed_text_type:)
    @discovery_engine_result = discovery_engine_result
    @displayed_text_type = displayed_text_type
  end

  delegate :title, :link, :description, :public_timestamp_datetime, to: :struct_data

  def url
    link.start_with?("http") ? link : "https://www.gov.uk#{link}"
  end

  def date
    return nil unless public_timestamp_datetime.present?

    Time.new(public_timestamp_datetime)
  end

  def displayed_text
    case displayed_text_type
    when "summary"
      derived_struct_data.extractive_answers&.first&.[]("content")
    when "snippets"
      derived_struct_data.snippets&.first&.[]("snippet")
    else
      description
    end
  end

private

  attr_reader :discovery_engine_result, :displayed_text_type

  def struct_data
    @struct_data ||= OpenStruct.new(discovery_engine_result.document.struct_data.to_h)
  end

  def derived_struct_data
    @derived_struct_data ||= OpenStruct.new(discovery_engine_result.document.derived_struct_data.to_h)
  end
end
