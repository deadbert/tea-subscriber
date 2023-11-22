class Api::V1::TeasController < ApplicationController

  def index
    render json: TeaSerializer.new(Tea.all)
  end

  def create
    render json: TeaSerializer.new(Tea.create(tea_parameters))
  end

  private

  def tea_parameters
    params.require(:tea).permit(:title, :description, :temperature, :brew_time)
  end
end