class ProjectQuestionsController < ApplicationController
  respond_to :json

  before_action :load_project_question, only: [:show, :update, :destroy]
  before_action :load_project_question_params, only: [:create, :update]
  before_action :load_project_questions, only: [:index]

  after_action :verify_authorized

  api :GET, '/project_questions', 'Returns a collection of project_questions'
  param :includes, Array, required: false, in: %w(project)

  def index
    authorize ProjectQuestion
    respond_with_params @project_questions
  end

  api :GET, '/project_questions/:id', 'Shows project_question with :id'
  param :id, :number, required: true
  param :includes, Array, required: false, in: %w(project)
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @project_question
    respond_with_params @project_question
  end

  api :POST, '/project_questions', 'Creates project_question'
  param :project_question, Hash, desc: 'ProjectQuestion' do
    param :question, String, desc: 'Question'
    param :field_type, String, desc: 'Field Type', in: %w(radio select_option text date)
    param :help_text, String, desc: 'Help Text'
    param :options, Array, desc: 'Options'
    param :required, :bool, desc: 'Required?'
  end
  error code: 422, desc: ParameterValidation::Messages.missing

  def create
    @project_question = ProjectQuestion.new @project_question_params
    authorize @project_question
    if @project_question.save
      respond_with @project_question
    else
      respond_with @project_question.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/project_questions/:id', 'Updates project_question with :id'
  param :id, :number, required: true
  param :project_question, Hash, desc: 'ProjectQuestion' do
    param :question, Array, desc: 'Question'
    param :field_type, String, desc: 'Field Type', in: %w(radio select_option text date)
    param :help_text, String, desc: 'Help Text'
    param :options, String, desc: 'Options'
    param :required, :bool, desc: 'Required?'
  end
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    authorize @project_question
    if @project_question.update_attributes @project_question_params
      respond_with @project_question
    else
      respond_with @project_question.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/project_questions/:id', 'Deletes project_question with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @project_question
    if @project_question.destroy
      respond_with @project_question
    else
      respond_with @project_question.errors, status: :unprocessable_entity
    end
  end

  private

  def load_project_question_params
    @project_question_params = params.require(:project_question).permit(:question, :field_type, :help_text, :options, :required)
  end

  def load_project_question
    @project_question = ProjectQuestion.find(params.require(:id))
  end

  def load_project_questions
    # TODO: Use a FormObject to encapsulate search filters, ordering, pagination
    @project_questions = query_with_includes ProjectQuestion.all
  end
end
