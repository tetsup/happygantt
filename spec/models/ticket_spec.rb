require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:ticket)).to be_valid
  end

  describe 'validate' do
    it 'is invalid without name' do
      ticket = FactoryBot.build(:ticket, :without_name)
      ticket.valid?
      expect(ticket.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without status' do
      ticket = FactoryBot.build(:ticket, :without_status)
      ticket.valid?
      expect(ticket.errors[:status]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without requirement' do
      ticket = FactoryBot.build(:ticket, :without_requirement)
      ticket.valid?
      expect(ticket.errors[:requirement]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid with long name' do
      ticket = FactoryBot.build(:ticket, :with_long_name)
      ticket.valid?
      expect(ticket.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 20))
    end

    it 'is invalid with duplicated name on same requirement' do
      requirement = FactoryBot.create(:requirement)
      FactoryBot.create(:ticket, requirement:)
      ticket = FactoryBot.build(:ticket, requirement:)
      ticket.valid?
      expect(ticket.errors[:name]).to include(I18n.t('errors.messages.taken'))
    end

    it 'is valid with duplicated name on different requirement' do
      milestone = FactoryBot.create(:milestone)
      requirement = FactoryBot.create(:requirement, milestone:)
      requirement2 = FactoryBot.create(:requirement, milestone:, name: '最強の装備を入手している')
      FactoryBot.create(:ticket, requirement:)
      ticket = FactoryBot.build(:ticket, requirement: requirement2)
      expect(ticket).to be_valid
    end
  end
end
