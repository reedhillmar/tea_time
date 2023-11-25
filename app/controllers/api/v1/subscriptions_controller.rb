class Api::V1::SubscriptionsController < ApplicationController
  def create
    customer = Customer.find(params[:customer_id])

    if customer
      customer.subscriptions.create(subscription_params)
      render json: { success: 'Subscription added' }, status: :created
    else
      render json: { errors: 'Customer does not exit' }, status: :unauthorized
    end
  end

  def update
    subscription = Subscription.find(params[:id])
    if subscription.update(status: params[:status])
      render json: SubscriptionSerializer.new(subscription), status: 201
    else
      render json: { errors: subscription.errors.full_messages }, status: 400
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency)
  end
end