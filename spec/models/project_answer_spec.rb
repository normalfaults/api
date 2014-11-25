describe ProjectAnswer do
  context 'associations' do
    it 'belongs to a project' do
      t = ProjectAnswer.reflect_on_association(:project)
      expect(t.macro).to eq(:belongs_to)
    end

    it 'belongs to a question' do
      t = ProjectAnswer.reflect_on_association(:project_question)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  context 'validations' do
    it 'must have a project question' do
      pa = build :project_answer, project_question_id: nil
      expect(pa.save).to eq(false)
      expect(pa.errors.keys.include?(:project_question)).to eq(true)
    end

    it 'must have valid project question id' do
      pa = build :project_answer, project_question_id: 9999
      expect(pa.save).to eq(false)
      expect(pa.errors.keys.include?(:project_question)).to eq(true)
    end

    it 'must have a project' do
      pa = build :project_answer, project_id: nil
      expect(pa.save).to eq(false)
      expect(pa.errors.keys.include?(:project)).to eq(true)
    end

    it 'must have valid project id' do
      pa = build :project_answer, project_id: 9999
      expect(pa.save).to eq(false)
      expect(pa.errors.keys.include?(:project)).to eq(true)
    end
  end
end
