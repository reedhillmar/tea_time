require 'rails_helper'

describe "Customers API" do
  context 'when a user sends a POST request to /api/v1/customers' do
    it 'allows the user to create a new customer' do
      customer_params = { first_name: "John", last_name: "Doe", email: "johndoe@test.com", address: "123 Main St" }

      post '/api/v1/customers', params: customer_params, as: :json

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to be_a(Hash)

      customer_data = response_body[:data]

      expect(customer_data).to have_key(:id)
      expect(customer_data[:id]).to be_a(String)

      expect(customer_data).to have_key(:type)
      expect(customer_data[:type]).to eq("customer")

      expect(customer_data).to have_key(:attributes)
      expect(customer_data[:attributes]).to be_a(Hash)

      customer_attributes = customer_data[:attributes]

      expect(customer_attributes).to have_key(:first_name)
      expect(customer_attributes[:first_name]).to eq('John')

      expect(customer_attributes).to have_key(:last_name)
      expect(customer_attributes[:last_name]).to eq('Doe')

      expect(customer_attributes).to have_key(:email)
      expect(customer_attributes[:email]).to eq('johndoe@test.com')

      expect(customer_attributes).to have_key(:address)
      expect(customer_attributes[:address]).to eq('123 Main St')
    end
  end

  context 'when a user sends a GET request to /api/v1/customers/:id' do
    it 'allows the user to see a specific customer and their subscriptions' do
      customer = create(:customer)
      create_list(:subscription, 3, customer_id: customer.id)

      get "/api/v1/customers/#{customer.id}", as: :json

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to be_a(Hash)

      customer_data = response_body[:data]
      
      expect(customer_data).to have_key(:relationships)
      expect(customer_data[:relationships]).to be_a(Hash)

      customer_relationships = customer_data[:relationships]

      expect(customer_relationships).to have_key(:subscriptions)
      expect(customer_relationships[:subscriptions]).to be_a(Hash)
      expect(customer_relationships[:subscriptions]).to have_key(:data)
      expect(customer_relationships[:subscriptions][:data]).to be_an(Array)
      expect(customer_relationships[:subscriptions][:data].count).to eq(3)
    end
  end
end