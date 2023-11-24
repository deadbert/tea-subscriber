class Api::V1::CustomersController < ApplicationController

  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: CustomerSerializer.new(customer)
    else
      render json: {error: "#{customer.errors.full_messages}"}
    end
  end

  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  private

  def customer_params
    params.permit(:first_name, :last_name, :email, :address, :password)
  end
end