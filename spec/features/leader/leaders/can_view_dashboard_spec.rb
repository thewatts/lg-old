require 'spec_helper'

feature 'Leader' do

  scenario 'can visit their dashboard' do
    user = create(:user, :nickname => "thewatts")
    current_user_is(user)
    visit leader_dashboard_path(:nickname => user.nickname)
    expect(page).to have_content "You don't have any groups yet"
  end

  "._-".chars.each do |char|
    scenario 'can finish signup if they have a #{char} in the nickname' do
      user = create(:user, :nickname => "the#{char}watts")
      current_user_is(user)
      visit leader_finish_signup_path(:nickname => user.nickname)
      expect(page).to have_content "Please finish"
    end
  end

  scenario 'is sent to dashboard from signup if already logged in' do
    user = create(:user, :nickname => "thewatts")
    current_user_is(user)
    visit leader_signup_path
    expect(page.current_url).to eq leader_dashboard_url(
      :nickname => user.nickname)
  end

  scenario 'is sent to finish signup from signup if current and incomplete' do
    user = create(:user, :nickname => "thewatts", :email => nil)
    current_user_is(user)
    visit leader_signup_path
    expect(page.current_url).to eq leader_finish_signup_url
  end
end
