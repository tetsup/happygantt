require 'rails_helper'

RSpec.describe 'Tickets', type: :system do
  let(:user) { create(:user) }
  let(:mission_user_relationship) { create(:mission_user_relationship, user:) }
  let(:mission) { mission_user_relationship.mission }
  let(:project) { create(:project, mission:) }
  let(:milestone) { create(:milestone, project:) }
  let(:requirement) { create(:requirement, milestone:) }
  let(:ticket) { create(:ticket, requirement:) }
  let(:ticket_doing) { create(:ticket, :doing, requirement:) }

  before do
    sign_in_as user
  end

  it 'creates a new ticket as a user' do
    expect {
      visit new_requirement_ticket_path(requirement_id: requirement.id)
      fill_in 'ticket[name]', with: 'やさしさ登録フォームの実装'
      select Ticket.statuses_i18n[:notyet], from: 'ticket[status]'
      click_button 'commit'
      expect(page).to have_content I18n.t('tickets.create.succeeded')
    }.to change(user.tickets, :count).by(1)
  end

  it 'updates status of a ticket as a user' do
    visit edit_ticket_path(id: ticket.id)
    select Ticket.statuses_i18n[:doing], from: 'ticket[status]'
    fill_in 'ticket[started_date]', with: '2022-12-31'
    click_button 'commit'
    expect(page).to have_content I18n.t('tickets.update.succeeded')
    expect(ticket.reload.status).to eq 'doing'
  end

  it 'destroies a ticket as a user' do
    visit edit_requirement_path(id: ticket.requirement.id)
    expect {
      click_link I18n.t('destroy')
      expect(page).to have_content I18n.t('tickets.destroy.succeeded')
    }.to change(user.tickets, :count).by(-1)
  end

  it 'updates status of a ticket to doing by toggle as a user' do
    visit edit_requirement_path(id: ticket.requirement.id)
    click_link I18n.t('methods.ticket.update_doing')
    expect(page).to have_content I18n.t('tickets.update_doing.succeeded')
    expect(ticket.reload.status).to eq 'doing'
  end

  it 'updates status of a ticket to done by toggle as a user' do
    visit edit_requirement_path(id: ticket_doing.requirement.id)
    click_link I18n.t('methods.ticket.update_done')
    expect(page).to have_content I18n.t('tickets.update_done.succeeded')
    expect(ticket_doing.reload.status).to eq 'done'
  end
end
