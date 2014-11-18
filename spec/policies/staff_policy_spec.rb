describe StaffPolicy do
  subject { StaffPolicy }

  let(:current_staff) { create :staff }
  let(:other_staff) { create :staff, :user }
  let(:admin) { create :staff, :admin }

  permissions :index? do
    it 'denies access if not an admin' do
      expect(subject).not_to permit(current_staff)
    end
    it 'allows access for an admin' do
      expect(subject).to permit(admin)
    end
  end

  permissions :show? do
    it 'prevents other staff from seeing your profile' do
      expect(subject).not_to permit(current_staff, other_staff)
    end
    it 'allows you to see your own profile' do
      expect(subject).to permit(current_staff, current_staff)
    end
    it 'allows an admin to see any profile' do
      expect(subject).to permit(admin)
    end
  end

  permissions :create? do
    it 'prevents creation if not an admin' do
      expect(subject).not_to permit(current_staff)
    end
    it 'allows an admin to create users' do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it 'prevents updates if not an admin' do
      expect(subject).not_to permit(current_staff)
    end
    it 'allows an admin to make updates' do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it 'prevents deleting yourself' do
      expect(subject).not_to permit(current_staff, current_staff)
    end
    it 'allows an admin to delete any staff' do
      expect(subject).to permit(admin, other_staff)
    end
  end

end
