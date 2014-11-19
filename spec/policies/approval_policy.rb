describe ApprovalPolicy do
  subject { ApprovalPolicy }

  let(:approval) { create :approval }
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
    it 'allows users to view approvals' do
      expect(subject).to permit(user, approval)
    end
    it 'allows an admin to see any approval' do
      expect(subject).to permit(admin, approval)
    end
  end

  permissions :create? do
    it 'prevents creation if not an admin' do
      expect(subject).not_to permit(current_staff)
    end
    it 'allows an admin to create approvals' do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it 'does not allow users to update approvals' do
      expect(subject).not_to permit(user, approval)
    end
    it 'allows an admin to make updates' do
      expect(subject).to permit(admin, approval)
    end
  end

  permissions :destroy? do
    it 'does not allow users to delete approvals' do
      expect(subject).to_not permit(user, approval)
    end
    it 'allows an admin to delete any approval' do
      expect(subject).to permit(admin, approval)
    end
  end
end
