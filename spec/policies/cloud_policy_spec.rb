describe CloudPolicy do
  subject { CloudPolicy }

  let(:cloud) { create :cloud }
  let(:current_staff) { create :staff }
  let(:admin) { create :staff, :admin }

  permissions :index? do
    it 'allows access for a user' do
      expect(subject).to permit(current_staff)
    end
    it 'allows access for an admin' do
      expect(subject).to permit(admin)
    end
  end

  permissions :show? do
    it 'does not allow users to view clouds' do
      expect(subject).to_not permit(current_staff, cloud)
    end
    it 'allows an admin to see any cloud' do
      expect(subject).to permit(admin, cloud)
    end
  end

  permissions :create? do
    it 'prevents creation if not an admin' do
      expect(subject).not_to permit(current_staff)
    end
    it 'allows an admin to create clouds' do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it 'does not allow users to update clouds' do
      expect(subject).not_to permit(current_staff, cloud)
    end
    it 'allows an admin to make updates' do
      expect(subject).to permit(admin, cloud)
    end
  end

  permissions :destroy? do
    it 'does not allow users to delete clouds' do
      expect(subject).to_not permit(current_staff, cloud)
    end
    it 'allows an admin to delete any cloud' do
      expect(subject).to permit(admin, cloud)
    end
  end
end
