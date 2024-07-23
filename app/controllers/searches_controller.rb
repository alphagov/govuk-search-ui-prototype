class SearchesController < ApplicationController
  def show; end

  helper_method :search, :query, :permitted_params

private

  def search
    @search ||= DiscoveryEngine.search(query, filter_expression, params[:sort]).then { Search.new(_1) }
  end

  def filter_expression
    Query::Filters.new(search_api_filter_params).filter_expression
  end

  def search_api_filter_params
    {
      filter_content_purpose_supergroup: permitted_params[:content_purpose_supergroups],
      filter_all_part_of_taxonomy_tree: [permitted_params[:primary_topic], permitted_params[:secondary_topic]].compact_blank,
    }.compact_blank
  end

  def query
    permitted_params[:q]
  end

  def permitted_params
    params.permit(:q, :sort, :primary_topic, :secondary_topic, content_purpose_supergroups: [])
  end
end
