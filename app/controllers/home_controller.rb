class HomeController < ApplicationController
  def index
    @blue_background = true
  end

  helper_method :search, :query

private

  def search
    @search ||= DiscoveryEngine.search(query).then { Search.new(_1) }
  end

  def query
    params.permit(:q)[:q]
  end
end
