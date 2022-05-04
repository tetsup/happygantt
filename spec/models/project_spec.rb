require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:project)).to be_valid
  end

  describe 'validate' do
    it 'is invalid without name' do
      project = FactoryBot.build(:project, :without_name)
      project.valid?
      expect(project.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without status' do
      project = FactoryBot.build(:project, :without_status)
      project.valid?
      expect(project.errors[:status]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without mission' do
      project = FactoryBot.build(:project, :without_mission)
      project.valid?
      expect(project.errors[:mission]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid with long name' do
      project = FactoryBot.build(:project, :with_long_name)
      project.valid?
      expect(project.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 20))
    end
  end
end
