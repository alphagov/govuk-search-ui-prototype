require "net/http"

class Api::TopicsController < ApplicationController
  def show; end

  def index
    uri = URI("https://www.gov.uk/api/content/" + params[:q])
    response = Net::HTTP.get(uri)

    render json: JSON.parse(response)["links"]["child_taxons"]
  end

private

  def complete_params
    params.permit(:q)
  end
end
