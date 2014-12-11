describe Staff do
  context 'search' do
    before :each do
      create :staff, email: 'foo@bar.com', first_name: 'John', last_name: 'Smith'
      create :staff, email: 'bar@foo.com', first_name: 'Jane', last_name: 'Doe'
    end

    it 'gets hits on emails' do
      results = Staff.search 'foo@bar.com'
      expect(results.size).to eq(1)
    end

    it 'gets hits on first name' do
      results = Staff.search 'John'
      expect(results.size).to eq(1)
    end

    it 'gets hits on last name' do
      results = Staff.search 'Smith'
      expect(results.size).to eq(1)
    end
  end
end
