class Api::V1::CustomersController < ApplicationController
  def create
    customer = Customer.new(customer_params)

    if customer.save
      render json: CustomerSerializer.new(customer), status: :created
    else
      render json: { errors: customer.errors.full_messages }, status: :bad_request
    end
  end

  def show
    customer = Customer.find(params[:id])

    render json: CustomerSerializer.new(customer), status: :ok
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :address)
  end
end