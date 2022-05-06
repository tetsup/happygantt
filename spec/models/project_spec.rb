require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'has a valid factory' do
    expect(build(:project)).to be_valid
  end

  describe 'validate' do
    it 'is invalid without name' do
      project = build(:project, :without_name)
      project.valid?
      expect(project.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without status' do
      project = build(:project, :without_status)
      project.valid?
      expect(project.errors[:status]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without mission' do
      project = build(:project, :without_mission)
      project.valid?
      expect(project.errors[:mission]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid with long name' do
      project = build(:project, :with_long_name)
      project.valid?
      expect(project.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 20))
    end

    it 'is invalid with duplicated name on same mission' do
      mission = create(:mission)
      create(:project, mission:)
      project = build(:project, mission:)
      project.valid?
      expect(project.errors[:name]).to include(I18n.t('errors.messages.taken'))
    end

    it 'is valid with duplicated name on different mission' do
      mission = create(:mission)
      mission2 = create(:mission, name: '地球を浄化する')
      create(:project, mission:)
      project = build(:project, mission: mission2)
      expect(project).to be_valid
    end
  end
end
