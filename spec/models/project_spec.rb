describe Project do
  context 'associations' do
    it 'has many project answers' do
      t = Project.reflect_on_association(:project_answers)
      expect(t.macro).to eq(:has_many)
    end
  end
end
