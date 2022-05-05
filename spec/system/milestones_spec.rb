require 'rails_helper'

RSpec.describe 'Milestones', type: :system do
  let(:user) { create(:user) }
  let(:mission_user_relationship) { create(:mission_user_relationship, user:) }
  let(:mission) { mission_user_relationship.mission }
  let(:project) { create(:project, mission:) }
  let(:milestone) { create(:milestone, project:) }

  before do
    sign_in_as user
  end

  it 'creates a new milestone as a user' do
    expect {
      visit new_project_milestone_path(project_id: project.id)
      fill_in 'milestone[name]', with: 'やさしさ募集機能実装'
      select Milestone.statuses_i18n[:notyet], from: 'milestone[status]'
      click_button 'commit'
      expect(page).to have_content I18n.t('milestones.create.succeeded')
    }.to change(user.milestones, :count).by(1)
  end

  it 'updates status of a milestone as a user' do
    visit edit_milestone_path(id: milestone.id)
    select Milestone.statuses_i18n[:doing], from: 'milestone[status]'
    click_button 'commit'
    expect(page).to have_content I18n.t('milestones.update.succeeded')
    expect(milestone.reload.status).to eq 'doing'
  end

  it 'destroies a milestone as a user' do
    visit edit_project_path(id: milestone.project.id)
    expect {
      click_button I18n.t('destroy')
      expect(page).to have_content I18n.t('milestones.destroy.succeeded')
    }.to change(user.milestones, :count).by(-1)
  end
end
