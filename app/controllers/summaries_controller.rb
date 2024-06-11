class SummariesController < ApplicationController
  DEFAULT_PROMPT_PREAMBLE = nil
  DEFAULT_SUMMARY_RESULT_COUNT = 5
  MAX_SUMMARY_RESULT_COUNT = 10

  def show; end

  helper_method :summary, :query, :prompt_preamble, :summary_result_count, :ignore_adversarial,
                :ignore_non_summary_seeking, :use_preview_model

private

  def summary
    return nil unless query

    @summary ||= DiscoveryEngine.summary(
      query,
      prompt_preamble:,
      summary_result_count:,
      ignore_adversarial:,
      ignore_non_summary_seeking:,
      use_preview_model:,
    ).then { Summary.new(_1, summary_result_count:) }
  end

  def query
    params.permit(:q)[:q]
  end

  def prompt_preamble
    params.permit(:prompt_preamble)[:prompt_preamble].presence || DEFAULT_PROMPT_PREAMBLE
  end

  def summary_result_count
    [
      params.permit(:summary_result_count)[:summary_result_count]&.to_i || DEFAULT_SUMMARY_RESULT_COUNT,
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
    params.permit(options: [])[:options] || []
  end
end
