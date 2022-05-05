module LoginSupport
  def sign_in_as(user)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'commit'
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
