class Playground::SummariesController < ApplicationController
  DEFAULT_TYPE = "summary".freeze
  DEFAULT_PROMPT_PREAMBLE = nil
  DEFAULT_SUMMARY_RESULT_COUNT = 5
  MAX_SUMMARY_RESULT_COUNT = 10

  layout "playground"

  def show; end

  helper_method :summary, :query, :type, :prompt_preamble, :summary_result_count,
                :ignore_adversarial, :ignore_non_summary_seeking, :use_preview_model,
                :summary_params

private

  def summary
    return nil unless query

    @summary ||= DiscoveryEngine.summary(
      query,
      type:,
      prompt_preamble:,
      summary_result_count:,
      ignore_adversarial:,
      ignore_non_summary_seeking:,
      use_preview_model:,
    ).then { Summary.new(_1, summary_result_count:, displayed_text_type: type) }
  end

  def query
    summary_params[:q]
  end

  def type
    summary_params[:type] || DEFAULT_TYPE
  end

  def prompt_preamble
    summary_params[:prompt_preamble].presence || DEFAULT_PROMPT_PREAMBLE
  end

  def summary_result_count
    [
      summary_params[:summary_result_count]&.to_i || DEFAULT_SUMMARY_RESULT_COUNT,
      MAX_SUMMARY_RESULT_COUNT,
    ].min
  end

  def ignore_adversarial
    options.include?("ignore_adversarial")
  end

  def ignore_non_summary_seeking
    options.include?("ignore_non_summary_seeking")
  end

  def use_preview_model
    options.include?("use_preview_model")
  end

  def options
    summary_params[:options] || []
  end

  def summary_params
    params.permit(:q, :type, :prompt_preamble, :summary_result_count, options: [])
  end
end
