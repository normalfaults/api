# == Schema Information
#
# Table name: staff
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)
#  phone                  :string(30)
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  role                   :integer          default(0)
#  deleted_at             :datetime
#  authentication_token   :string(255)
#
# Indexes
#
#  index_staff_on_authentication_token  (authentication_token) UNIQUE
#  index_staff_on_deleted_at            (deleted_at)
#  index_staff_on_email                 (email) UNIQUE
#  index_staff_on_reset_password_token  (reset_password_token) UNIQUE
#

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
