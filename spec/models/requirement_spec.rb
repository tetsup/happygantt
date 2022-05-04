require 'rails_helper'

RSpec.describe Requirement, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:requirement)).to be_valid
  end

  describe 'validate' do
    it 'is invalid without name' do
      requirement = FactoryBot.build(:requirement, :without_name)
      requirement.valid?
      expect(requirement.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without milestone' do
      requirement = FactoryBot.build(:requirement, :without_milestone)
      requirement.valid?
      expect(requirement.errors[:milestone]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid with long name' do
      requirement = FactoryBot.build(:requirement, :with_long_name)
      requirement.valid?
      expect(requirement.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 20))
    end

    it 'is invalid with duplicated name on same milestone' do
      milestone = FactoryBot.create(:milestone)
      FactoryBot.create(:requirement, milestone:)
      requirement = FactoryBot.build(:requirement, milestone:)
      requirement.valid?
      expect(requirement.errors[:name]).to include(I18n.t('errors.messages.taken'))
    end

    it 'is valid with duplicated name on different milestone' do
      project = FactoryBot.create(:project)
      milestone = FactoryBot.create(:milestone, project:)
      milestone2 = FactoryBot.create(:milestone, project:, name: '魔法を習得する')
      FactoryBot.create(:requirement, milestone:)
      requirement = FactoryBot.build(:requirement, milestone: milestone2)
      expect(requirement).to be_valid
    end
  end
end
