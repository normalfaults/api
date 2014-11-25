describe Project do
  context 'associations' do
    it 'has many project answers' do
      t = Project.reflect_on_association(:project_answers)
      expect(t.macro).to eq(:has_many)
    end
  end

  context 'creation' do
    let(:answer) { 'Why did the chicken cross the road?' }
    let(:question) { 'To get to the other side.' }
    let(:project_name) { 'To get to the other side.' }
    let(:question_model) { create :project_question, question: question, load_order: 0 }

    it 'creates answers w/ a project' do
      answers = [{ project_question_id: question_model.id, answer: answer }]
      project = Project.create_with_answers(project_answers: answers, name: project_name)
      expect(project.project_answers.count).to eq(answers.count)
    end

    it 'raises an exception when answers are missing a question' do
      answers = [{ project_question_id: nil, answer: answer }]
      expect { Project.create_with_answers(project_answers: answers, name: project_name) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
