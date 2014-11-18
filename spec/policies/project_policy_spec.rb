describe ProjectPolicy do
  subject { ProjectPolicy }

  let(:project) { create :project }
  let(:current_staff) { create :staff }
  let(:admin) { create :staff, :admin }
  let(:user) do
    user = create :staff, :user
    user.projects << project
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
    it 'prevents unassociated users from viewing projects' do
      expect(subject).not_to permit(current_staff, project)
    end
    it 'allows you to see your projects' do
      expect(subject).to permit(user, project)
    end
    it 'allows an admin to see any project' do
      expect(subject).to permit(admin, project)
    end
  end

  permissions :create? do
    it 'prevents creation if not an admin' do
      expect(subject).not_to permit(current_staff)
    end
    it 'allows an admin to create projects' do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it 'prevents updates if not an associated user' do
      expect(subject).not_to permit(current_staff, project)
    end
    it 'allows you to update your projects' do
      expect(subject).to permit(user, project)
    end
    it 'allows an admin to make updates' do
      expect(subject).to permit(admin, project)
    end
  end

  permissions :destroy? do
    it 'prevents an unassociated user from deleting a project' do
      expect(subject).not_to permit(current_staff, project)
    end
    it 'allows you to delete your projects' do
      expect(subject).to permit(user, project)
    end
    it 'allows an admin to delete any project' do
      expect(subject).to permit(admin, project)
    end
  end

end
