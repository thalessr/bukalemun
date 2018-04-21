# frozen_string_literal: true

class ContentsController < ApplicationController

  before_action :require_authentication!

  def create
    content = Content.new(content_params)
    if content.save
      render json: content, status: :created
    else
      render json: { errors: content.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    content = Content.find(params[:id])
    if content.present?
      render json: content, status: :found
    else
      render json: { errors: 'Maybe you can find it using google 8-)' }, status: :not_found
    end
  end

  private

  def content_params
    params.require(:content).permit(:ower_id, :recipient_id, :message)
  end

end
