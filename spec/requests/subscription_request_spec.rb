require 'rails_helper'

describe "Subscriptions API" do
  context 'when a user sends a POST request to /api/v1/subscriptions' do
    it 'allows the user to create a new subscription' do
      customer = create(:customer)

      subscription_params = { title: "Tea of the Month", price: 10.00, status: 0, frequency: 0, customer_id: customer.id }

      post '/api/v1/subscriptions', params: subscription_params, as: :json

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(response_body).to have_key(:success)
      expect(response_body[:success]).to eq('Subscription added')

      expect(customer.subscriptions.count).to eq(1)

      customer_subscription = customer.subscriptions.first

      expect(customer_subscription.title).to eq('Tea of the Month')
      expect(customer_subscription.price).to eq(10.00)
      expect(customer_subscription.status).to eq('active')
      expect(customer_subscription.frequency).to eq('monthly')
      expect(customer_subscription.customer_id).to eq(customer.id)
    end
  end

  context 'when a user sends a PATCH request to /api/v1/subscriptions/:id' do
    it 'allows the user to update a subscription' do
      customer = create(:customer)
      subscription = create(:subscription, customer_id: customer.id)

      patch "/api/v1/subscriptions/#{subscription.id}", params: { status: 1 }, as: :json

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to be_a(Hash)

      subscription_data = response_body[:data]

      expect(subscription_data).to have_key(:id)
      expect(subscription_data[:id]).to eq(subscription.id.to_s)

      expect(subscription_data).to have_key(:type)
      expect(subscription_data[:type]).to eq('subscription')

      expect(subscription_data).to have_key(:attributes)
      expect(subscription_data[:attributes]).to be_a(Hash)

      subscription_attributes = subscription_data[:attributes]

      expect(subscription_attributes).to have_key(:title)
      expect(subscription_attributes[:title]).to eq(subscription.title)
      
      expect(subscription_attributes).to have_key(:price)
      expect(subscription_attributes[:price]).to eq(subscription.price)

      expect(subscription_attributes).to have_key(:status)
      expect(subscription_attributes[:status]).to eq('cancelled')

      expect(subscription_attributes).to have_key(:frequency)
      expect(subscription_attributes[:frequency]).to eq(subscription.frequency)
    end
  end
end