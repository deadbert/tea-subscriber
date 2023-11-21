class Api::V1::SubscriptionsController < ApplicationController

  def create
    new_sub = Subscription.new(subscription_params)
    if new_sub.save
      render json: SubscriptionSerializer.new(new_sub)
    else
      render json: {error: "#{new_sub.errors.full_messages.join(',')}"}, status: :conflict
    end
  end

  def index
    begin
      customer = Customer.find(params[:customer_id])
      render json: SubscriptionSerializer.new(customer.subscriptions)
    rescue ActiveRecord::RecordNotFound => e
      render json: {error: "#{e.message}"}, status: :not_found
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
  end
end