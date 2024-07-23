class SearchesController < ApplicationController
  def show; end

  helper_method :search, :query, :filter_params

private

  def search
    @search ||= DiscoveryEngine.search(query, filter_expression, params[:sort]).then { Search.new(_1) }
  end

  def filter_expression
    Query::Filters.new(search_api_filter_params).filter_expression
  end

  def search_api_filter_params
    {
      filter_content_purpose_supergroup: filter_params[:content_purpose_supergroups],
      filter_all_part_of_taxonomy_tree: [filter_params[:primary_topic], filter_params[:secondary_topic]].compact_blank,
    }.compact_blank
  end

  def filter_params
    params.permit(
      :primary_topic,
      :secondary_topic,
      content_purpose_supergroups: [],
    )
  end

  def query
    params.permit(:q)[:q]
  end
end
