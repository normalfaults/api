# == Schema Information
#
# Table name: project_questions
#
#  id         :integer          not null, primary key
#  question   :string(255)
#  help_text  :string(255)
#  required   :boolean
#  created_at :datetime
#  updated_at :datetime
#  deleted_at :datetime
#  load_order :integer
#  options    :json
#  field_type :integer          default(0)
#
# Indexes
#
#  index_project_questions_on_deleted_at  (deleted_at)
#

describe ProjectQuestion do
  context 'associations' do
    it 'has many project answers' do
      t = Project.reflect_on_association(:project_answers)
      expect(t.macro).to eq(:has_many)
    end
  end

  context 'validations' do
    it 'must have a question' do
      pq = build :project_question, question: nil
      expect(pq.save).to eq(false)
      expect(pq.errors.keys.include?(:question)).to eq(true)
    end

    it 'must have a field_type' do
      pq = build :project_question, field_type: nil
      expect(pq.save).to eq(false)
      expect(pq.errors.keys.include?(:field_type)).to eq(true)
    end
  end

  context 'options' do
    let(:options) { %w(test1 test2) }

    it 'can store unstructured options' do
      create :project_question, options: options
      project_question =  ProjectQuestion.first

      expect(project_question.options[0]).to eq(options[0]['test1'])
      expect(project_question.options[1]).to eq(options[1]['test2'])
    end
  end
end
