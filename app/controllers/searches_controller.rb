require "net/http"
require "json"

class SearchesController < ApplicationController
  before_action :level_one_topics, only: [:show]

  before_action :level_two_topics, only: [:show]

  def show; end

  helper_method :search, :query, :level_one_topics, :level_two_topics

private

  def level_one_topics
    uri = URI("https://www.gov.uk/api/content")
    response = Net::HTTP.get(uri)

    @level_one_topics ||= JSON.parse(response)["links"]["level_one_taxons"].sort_by { |obj| obj[:title] }
  end

  def level_two_topics
    if params[:level_one_taxon].present?

      level_one = @level_one_topics.find { |t| t["content_id"] == params[:level_one_taxon] }
      uri = URI("https://www.gov.uk/api/content/#{level_one['base_path']}")
      response = Net::HTTP.get(uri)

      @level_two_topics ||= JSON.parse(response)["links"]["child_taxons"].sort_by { |obj| obj[:title] }

    else
      @level_two_topics = []
    end
  end

  def search
    @search ||= DiscoveryEngine.search(query, filter_expression, params[:sort]).then { Search.new(_1) }
  end

  def filter_expression
    Query::Filters.new(filter).filter_expression
  end

  def filter
    params.permit!
  end

  def query
    params.permit(:q, :filter_content_purpose_supergroup)[:q]
  end
end
