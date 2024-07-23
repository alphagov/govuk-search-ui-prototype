require "net/http"
require "json"

class SearchesController < ApplicationController
  def show; end

  helper_method :search, :query

private

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
