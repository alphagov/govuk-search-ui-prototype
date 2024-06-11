class SummariesController < ApplicationController
  DEFAULT_PROMPT_PREAMBLE = nil

  def show; end

  helper_method :summary, :query, :prompt_preamble, :ignore_adversarial,
                :ignore_non_summary_seeking, :use_preview_model

private

  def summary
    return nil unless query

    @summary ||= DiscoveryEngine.summary(
      query,
      prompt_preamble:,
      ignore_adversarial:,
      ignore_non_summary_seeking:,
      use_preview_model:,
    ).then { Summary.new(_1) }
  end

  def query
    params.permit(:q)[:q]
  end

  def prompt_preamble
    params.permit(:prompt_preamble)[:prompt_preamble].presence || DEFAULT_PROMPT_PREAMBLE
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
