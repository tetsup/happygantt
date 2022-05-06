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

    it 'is valid with started_date if doing' do
      ticket = build(:ticket, :doing)
      expect(ticket).to be_valid
    end

    it 'is invalid without started_date if doing' do
      ticket = build(:ticket, :doing, started_date: nil)
      ticket.valid?
      expect(ticket.errors[:started_date]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is valid with started and ended_date if done' do
      ticket = build(:ticket, :done)
      expect(ticket).to be_valid
    end

    it 'is invalid without started_date if done' do
      ticket = build(:ticket, :done, started_date: nil)
      ticket.valid?
      expect(ticket.errors[:started_date]).to include(I18n.t('errors.messages.blank'))
    end

    it 'is invalid without ended_date if done' do
      ticket = build(:ticket, :done, ended_date: nil)
      ticket.valid?
      expect(ticket.errors[:ended_date]).to include(I18n.t('errors.messages.blank'))
    end
  end

  describe 'toggler' do
    let(:ticket_notyet) { create(:ticket) }
    let(:ticket_doing) { create(:ticket, :doing) }
    let(:ticket_done) { create(:ticket, :done) }

    it 'changes status from notyet to doing' do
      ticket_notyet.toggle_doing
      expect(ticket_notyet).to be_valid
      expect(ticket_notyet.doing?).to be true
      expect(ticket_notyet.started_date).not_to eq nil
    end

    it 'changes status from doing to notyet' do
      ticket_doing.toggle_done
      expect(ticket_doing).to be_valid
      expect(ticket_doing.done?).to be true
      expect(ticket_doing.ended_date).not_to eq nil
    end

    it 'do not chenges status from notyet to done' do
      ticket_notyet.toggle_done
      expect(ticket_notyet.notyet?).to be true      
    end

    it 'do not changes status from done to doing' do
      ticket_done.toggle_doing
      expect(ticket_done.done?).to be true
    end

    it 'do not change started_date if doing' do
      expect {
        ticket_doing.toggle_doing
      }.not_to(change { ticket_doing.started_date })
    end

    it 'do not change started_date if done' do
      expect {
        ticket_done.toggle_doing
      }.not_to(change { ticket_done.started_date })
    end

    it 'do not change ended_date if done' do
      expect {
        ticket_done.toggle_done
      }.not_to(change { ticket_done.ended_date })
    end
  end
end
