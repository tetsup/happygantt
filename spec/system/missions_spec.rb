require 'rails_helper'

RSpec.describe 'Missions', type: :system do
  let(:user) { create(:user) }
  let(:mission_user_relationship) { create(:mission_user_relationship, user:) }
  let(:mission) { mission_user_relationship.mission }

  before do
    sign_in_as user
  end

  it 'creates a new mission as a user' do
    expect {
      visit new_mission_path
      fill_in 'mission[name]', with: '世界平和'
      select Milestone.statuses_i18n[:notyet], from: 'mission[status]'
      click_button 'commit'
      expect(page).to have_content I18n.t('missions.create.succeeded')
    }.to change(user.missions, :count).by(1)
  end

  it 'updates status of a mission as a user' do
    visit edit_mission_path(id: mission.id)
    select Milestone.statuses_i18n[:doing], from: 'mission[status]'
    click_button 'commit'
    expect(page).to have_content I18n.t('missions.update.succeeded')
    expect(mission.reload.status).to eq 'doing'
  end

  it 'destroies a mission as a user' do
    mission
    visit missions_path
    expect {
      click_button I18n.t('destroy')
      expect(page).to have_content I18n.t('missions.destroy.succeeded')
    }.to change(user.missions, :count).by(-1)
  end
end
