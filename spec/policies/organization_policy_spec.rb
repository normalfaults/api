describe OrganizationPolicy do
  subject { OrganizationPolicy }

  let(:organization) { create :organization }
  let(:current_staff) { create :staff }
  let(:admin) { create :staff, :admin }
  let(:user) do
    user = create :staff, :user
    user
  end

  permissions :index? do
    it 'allows access for a user' do
      expect(subject).to permit(current_staff)
    end
    it 'allows access for an admin' do
      expect(subject).to permit(admin)
    end
  end

  permissions :show? do
    it 'allows users to view organizations' do
      expect(subject).to permit(user, organization)
    end
    it 'allows an admin to see any organization' do
      expect(subject).to permit(admin, organization)
    end
  end

  permissions :create? do
    it 'prevents creation if not an admin' do
      expect(subject).not_to permit(current_staff)
    end
    it 'allows an admin to create organizations' do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it 'does not allow users to update organizations' do
      expect(subject).not_to permit(user, organization)
    end
    it 'allows an admin to make updates' do
      expect(subject).to permit(admin, organization)
    end
  end

  permissions :destroy? do
    it 'does not allow users to delete organizations' do
      expect(subject).to_not permit(user, organization)
    end
    it 'allows an admin to delete any organization' do
      expect(subject).to permit(admin, organization)
    end
  end
end
