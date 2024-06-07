class SearchesController < ApplicationController
  def show
    @results = search.results
  end

  helper_method :query

private

  def search
    @search ||= DiscoveryEngine.search(query)
  end

  def query
    params.permit(:q)[:q]
  end
end
