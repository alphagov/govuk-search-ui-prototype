class Api::AutocompletesController < ApplicationController
  def show; end

  def index
    render json: DiscoveryEngine.complete(
      complete_params[:q],
      model: complete_params[:model],
      include_tail: complete_params[:include_tail] != "false",
    )
  end

private

  def complete_params
    params.permit(:q, :model, :include_tail)
  end
end
