class Api::V1::SubscriptionsController < ApplicationController

  def create
    new_sub = Subscription.create(subscription_params)

  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
  end
end