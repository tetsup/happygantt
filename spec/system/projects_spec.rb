require 'rails_helper'

RSpec.describe 'Projects', type: :system do
  let(:user) { create(:user) }
  let(:mission_user_relationship) { create(:mission_user_relationship, user:) }
  let(:mission) { mission_user_relationship.mission }
  let(:project) { create(:project, mission:) }

  before do
    sign_in_as user
  end

  it 'creates a new project as a user' do
    expect {
      visit new_mission_project_path(mission_id: mission.id)
      fill_in 'project[name]', with: 'やさしさを拡散する'
      select Project.statuses_i18n[:notyet], from: 'project[status]'
      click_button 'commit'
      expect(page).to have_content I18n.t('projects.create.succeeded')
    }.to change(user.projects, :count).by(1)
  end

  it 'updates status of a project as a user' do
    visit edit_project_path(id: project.id)
    select Project.statuses_i18n[:doing], from: 'project[status]'
    click_button 'commit'
    expect(page).to have_content I18n.t('projects.update.succeeded')
    expect(project.reload.status).to eq 'doing'
  end

  it 'destroies a project as a user' do
    visit edit_mission_path(id: project.mission.id)
    expect {
      click_button I18n.t('destroy')
      expect(page).to have_content I18n.t('projects.destroy.succeeded')
    }.to change(user.projects, :count).by(-1)
  end
end
