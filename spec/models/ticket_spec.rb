require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it 'has a valid factory' do
    expect(build(:ticket)).to be_valid
  end

  describe 'validate' do
    it 'is invalid without name' do
      ticket = build(:ticket, :without_name)
      ticket.valid?
      expect(ticket.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without status' do
      ticket = build(:ticket, :without_status)
      ticket.valid?
      expect(ticket.errors[:status]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without requirement' do
      ticket = build(:ticket, :without_requirement)
      ticket.valid?
      expect(ticket.errors[:requirement]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid with long name' do
      ticket = build(:ticket, :with_long_name)
      ticket.valid?
      expect(ticket.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 20))
    end

    it 'is invalid with duplicated name on same requirement' do
      requirement = create(:requirement)
      create(:ticket, requirement:)
      ticket = build(:ticket, requirement:)
      ticket.valid?
      expect(ticket.errors[:name]).to include(I18n.t('errors.messages.taken'))
    end

    it 'is valid with duplicated name on different requirement' do
      milestone = create(:milestone)
      requirement = create(:requirement, milestone:)
      requirement2 = create(:requirement, milestone:, name: '最強の装備を入手している')
      create(:ticket, requirement:)
      ticket = build(:ticket, requirement: requirement2)
      expect(ticket).to be_valid
    end
  end
end
