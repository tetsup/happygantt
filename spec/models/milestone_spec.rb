require 'rails_helper'

RSpec.describe Milestone, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:milestone)).to be_valid
  end

  describe 'validate' do
    it 'is invalid without name' do
      milestone = FactoryBot.build(:milestone, :without_name)
      milestone.valid?
      expect(milestone.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without status' do
      milestone = FactoryBot.build(:milestone, :without_status)
      milestone.valid?
      expect(milestone.errors[:status]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without project' do
      milestone = FactoryBot.build(:milestone, :without_project)
      milestone.valid?
      expect(milestone.errors[:project]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid with long name' do
      milestone = FactoryBot.build(:milestone, :with_long_name)
      milestone.valid?
      expect(milestone.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 50))
    end

    it 'is invalid with duplicated name on same project' do
      project = FactoryBot.create(:project)
      FactoryBot.create(:milestone, project:)
      milestone = FactoryBot.build(:milestone, project:)
      milestone.valid?
      expect(milestone.errors[:name]).to include(I18n.t('errors.messages.taken'))
    end

    it 'is valid with duplicated name on different project' do
      mission = FactoryBot.create(:mission)
      project = FactoryBot.create(:project, mission:)
      project2 = FactoryBot.create(:project, mission:, name: '世界の果てに到達する')
      FactoryBot.create(:milestone, project:)
      milestone = FactoryBot.build(:milestone, project: project2)
      expect(milestone).to be_valid
    end
  end
end
