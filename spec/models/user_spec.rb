require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'validate' do
    it 'is invalid without name' do
      user = build(:user, :without_name)
      user.valid?
      expect(user.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without email' do
      user = build(:user, :without_email)
      user.valid?
      expect(user.errors[:email]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without password' do
      user = build(:user, :without_password)
      user.valid?
      expect(user.errors[:password]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without timezone' do
      user = build(:user, :without_timezone)
      user.valid?
      expect(user.errors[:time_zone]).to include(I18n.t('errors.messages.inclusion'))
    end

    it 'is invalid with wrong timezone' do
      user = build(:user, :with_wrong_timezone)
      user.valid?
      expect(user.errors[:time_zone]).to include(I18n.t('errors.messages.inclusion'))
    end

    it 'is invalid with duplicated name' do
      create(:user)
      user = build(:user)
      user.valid?
      expect(user.errors[:name]).to include(I18n.t('errors.messages.taken'))
    end

    it 'is invalid with duplicated email' do
      create(:user)
      user = build(:user)
      user.valid?
      expect(user.errors[:email]).to include(I18n.t('errors.messages.taken'))
    end
  end
end
