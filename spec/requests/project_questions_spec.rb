require 'rails_helper'

RSpec.describe 'ProjectQuestions API' do
  describe 'GET index' do
    before(:each) do
      create :project_question
      create :project_question
      @project_questions = ProjectQuestion.all
      sign_in_as create :staff, :admin
    end

    it 'returns a collection of all of the project_questions', :show_in_doc do
      get '/project_questions'
      expect(json.length).to eq(2)
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
      put "/project_questions/#{@project_question.id}", project_question: { required: true }
      expect(response.status).to eq(204)
    end

    it 'returns an error if the project_question parameter is missing' do
      put "/project_questions/#{@project_question.id}"
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: project_question')
    end

    it 'returns an error when the project_question does not exist' do
      put "/project_questions/#{@project_question.id + 999}", project_question: { required: true  }
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
      post '/project_questions/', project_question: @project_question.as_json
      expect(response.body).to eq(ProjectQuestion.first.to_json)
    end

    it 'returns an error if the project_question is missing' do
      post '/project_questions/'
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: project_question')
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
