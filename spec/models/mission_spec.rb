require 'rails_helper'

RSpec.describe Mission, type: :model do
  it 'has a valid factory' do
    expect(build(:mission)).to be_valid
  end

  describe 'validate' do
    it 'is invalid without name' do
      mission = build(:mission, :without_name)
      mission.valid?
      expect(mission.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without status' do
      mission = build(:mission, :without_status)
      mission.valid?
      expect(mission.errors[:status]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid with long name' do
      mission = build(:mission, :with_long_name)
      mission.valid?
      expect(mission.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 20))
    end

    it 'is invalid with duplicated name' do
      create(:mission)
      mission = build(:mission)
      mission.valid?
      expect(mission.errors[:name]).to include(I18n.t('errors.messages.taken'))
    end
  end
end
