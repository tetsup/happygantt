require 'rails_helper'

RSpec.describe Requirement, type: :model do
  it 'has a valid factory' do
    expect(build(:requirement)).to be_valid
  end

  describe 'validate' do
    it 'is invalid without name' do
      requirement = build(:requirement, :without_name)
      requirement.valid?
      expect(requirement.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without milestone' do
      requirement = build(:requirement, :without_milestone)
      requirement.valid?
      expect(requirement.errors[:milestone]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid with long name' do
      requirement = build(:requirement, :with_long_name)
      requirement.valid?
      expect(requirement.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 20))
    end

    it 'is invalid with duplicated name on same milestone' do
      milestone = create(:milestone)
      create(:requirement, milestone:)
      requirement = build(:requirement, milestone:)
      requirement.valid?
      expect(requirement.errors[:name]).to include(I18n.t('errors.messages.taken'))
    end

    it 'is valid with duplicated name on different milestone' do
      project = create(:project)
      milestone = create(:milestone, project:)
      milestone2 = create(:milestone, project:, name: '魔法を習得する')
      create(:requirement, milestone:)
      requirement = build(:requirement, milestone: milestone2)
      expect(requirement).to be_valid
    end
  end
end
