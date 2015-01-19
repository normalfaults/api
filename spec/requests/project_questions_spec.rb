require 'rails_helper'

RSpec.describe 'ProjectQuestions API' do
  let(:default_params) { { format: :json } }

  describe 'GET index' do
    before(:each) do
      @pq1 = create :project_question
      @pq2 = create :project_question, :required_text

      @project_questions = ProjectQuestion.all
      sign_in_as create :staff, :admin
    end

    it 'returns a collection of all of the project_questions', :show_in_doc do
      get '/project_questions'
      expect(json.length).to eq(2)
    end

    it 'paginates the project_questions' do
      get '/project_questions', page: 1, per_page: 1
      expect(json.length).to eq(1)
    end
  end

  describe 'GET show' do
    before(:each) do
      @project_question = create :project_question
      sign_in_as create :staff, :admin
    end

    it 'returns an project_question', :show_in_doc do
      get "/project_questions/#{@project_question.id}"
      expect(json['id']).to eq(@project_question.id)
    end

    it 'returns an error when the project_question does not exist' do
      get "/project_questions/#{@project_question.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'PUT update' do
    before(:each) do
      create :project_question, :optional
      @project_question = ProjectQuestion.first
      sign_in_as create :staff, :admin
    end

    it 'updates a project_question', :show_in_doc do
      put "/project_questions/#{@project_question.id}", required: true
      expect(response.status).to eq(204)
    end

    it 'returns an error when the project_question does not exist' do
      put "/project_questions/#{@project_question.id + 999}", required: true
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    before :each do
      @project_question = build :project_question
      sign_in_as create :staff, :admin
    end

    it 'creates an project_question', :show_in_doc do
      post '/project_questions/', @project_question.as_json
      expect(response.body).to eq(ProjectQuestion.first.to_json)
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @project_question = create :project_question
      sign_in_as create :staff, :admin
    end

    it 'removes the product', :show_in_doc do
      delete "/project_questions/#{@project_question.id}"
      expect(response.status).to eq(204)
    end

    it 'returns an error when the product does not exist' do
      delete "/project_questions/#{@project_question.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end
end
