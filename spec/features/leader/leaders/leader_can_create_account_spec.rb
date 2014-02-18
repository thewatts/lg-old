require 'spec_helper'

feature "leader" do

  scenario "signs up for an account with Facebook and is prompted to finish" do
    user = signup_user_with_facebook
    expect( page.body ).to have_content "Thanks for signing up, #{user.name}!"
    expect( page.current_url ).to eq leader_finish_signup_url(
      :nickname => user.nickname)
  end

  scenario "finishes their signup process by entering email" do
    user = signup_user_with_facebook
    nickname = user.nickname
    name     = user.name
    expect( page.current_url ).to eq leader_finish_signup_url(
      :nickname => user.nickname)

    fill_in "Email", :with => "joe@bloggs.com"
    click_on "Finish Signup"
    expect( page.body ).to have_content "You're officially signed up, #{name}!"
    expect( page.current_url ).to eq leader_dashboard_url(:nickname => nickname)
  end
end
