class Api::AutocompletesController < ApplicationController
  def show; end

  helper_method :autocomplete, :query

  def index
    render json: DiscoveryEngine.complete(query)
  end

private

  def query
    params.permit(:q)[:q]
  end
end
