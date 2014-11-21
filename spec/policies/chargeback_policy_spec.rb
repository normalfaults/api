describe ChargebackPolicy do
  subject { ChargebackPolicy }

  let(:chargeback) { create :chargeback }
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
    it 'does not allow users to view chargebacks' do
      expect(subject).to_not permit(current_staff, chargeback)
    end
    it 'allows an admin to see any chargeback' do
      expect(subject).to permit(admin,chargeback)
    end
  end

  permissions :create? do
    it 'prevents creation if not an admin' do
      expect(subject).not_to permit(current_staff)
    end
    it 'allows an admin to create chargebacks' do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it 'does not allow users to update chargebacks' do
      expect(subject).not_to permit(current_staff, chargeback)
    end
    it 'allows an admin to make updates' do
      expect(subject).to permit(admin, chargeback)
    end
  end

  permissions :destroy? do
    it 'does not allow users to delete chargebacks' do
      expect(subject).to_not permit(current_staff, chargeback)
    end
    it 'allows an admin to delete any chargeback' do
      expect(subject).to permit(admin, chargeback)
    end
  end
end