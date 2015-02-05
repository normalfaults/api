describe Staff do
  it { expect(subject).to respond_to :authentication_token } # Token authentication

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

  describe '#ensure_authentication_token' do # Token authentication
    context 'when the user has no authentication token' do

      subject(:user_created_without_auth_token) { FactoryGirl.create(:user) }

      it 'creates one' do
        expect(subject.authentication_token).not_to be_blank
      end
    end
  end
end
