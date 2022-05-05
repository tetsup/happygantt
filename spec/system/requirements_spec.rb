require 'rails_helper'

RSpec.describe 'Requirements', type: :system do
  let(:user) { create(:user) }
  let(:mission_user_relationship) { create(:mission_user_relationship, user:) }
  let(:mission) { mission_user_relationship.mission }
  let(:project) { create(:project, mission:) }
  let(:milestone) { create(:milestone, project:) }
  let(:requirement) { create(:requirement, milestone:) }

  before do
    sign_in_as user
  end

  it 'creates a new requirement as a user' do
    expect {
      visit new_milestone_requirement_path(milestone_id: milestone.id)
      fill_in 'requirement[name]', with: 'やさしさを登録できる'
      click_button 'commit'
      expect(page).to have_content I18n.t('requirements.create.succeeded')
    }.to change(user.requirements, :count).by(1)
  end

  it 'updates name of a requirement as a user' do
    visit edit_requirement_path(id: requirement.id)
    fill_in 'requirement[name]', with: 'やっぱりやさしさは登録できない'
    click_button 'commit'
    expect(page).to have_content I18n.t('requirements.update.succeeded')
    expect(requirement.reload.name).to eq 'やっぱりやさしさは登録できない'
  end

  it 'destroies a requirement as a user' do
    visit edit_milestone_path(id: requirement.milestone_id)
    expect {
      click_button I18n.t('destroy')
      expect(page).to have_content I18n.t('requirements.destroy.succeeded')
    }.to change(user.requirements, :count).by(-1)
  end
end
