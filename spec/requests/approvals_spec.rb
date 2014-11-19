require 'rails_helper'

RSpec.describe 'Approvals API' do
  describe 'GET index' do
    before(:each) do
      create :approval
      create :approval
      @approvals = Approval.all
      sign_in_as create :staff, :admin
    end

    it 'returns a collection of all of the approvals' do
      get '/approvals'
      expect(json.length).to eq(2)
    end
  end

  describe 'GET show' do
    before(:each) do
      @approval = create :approval
      sign_in_as create :staff, :admin
    end

    it 'returns an approval' do
      get "/approvals/#{@approval.id}"
      expect(json['id']).to eq(@approval.id)
    end

    it 'returns an error when the approval does not exist' do
      get "/approvals/#{@approval.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'PUT update' do
    before(:each) do
      create :approval, :unapproved
      @approval = Approval.first
      sign_in_as create :staff, :admin
    end

    it 'updates a approval' do
      put "/approvals/#{@approval.id}", approval: { approved: true }
      expect(response.status).to eq(204)
    end

    it 'returns an error if the approval parameter is missing' do
      put "/approvals/#{@approval.id}"
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: approval')
    end

    it 'returns an error when the approval does not exist' do
      put "/approvals/#{@approval.id + 999}", approval: { approved: true  }
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    before :each do
      @approval = build :approval
      sign_in_as create :staff, :admin
    end

    it 'creates an approval' do
      post '/approvals/', approval: @approval.as_json
      expect(response.body).to eq(Approval.first.to_json)
    end

    it 'returns an error if the approval is missing' do
      post '/approvals/'
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: approval')
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @approval = create :approval
      sign_in_as create :staff, :admin
    end

    it 'removes the product' do
      delete "/approvals/#{@approval.id}"
      expect(response.status).to eq(204)
    end

    it 'returns an error when the product does not exist' do
      delete "/approvals/#{@approval.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end
end
