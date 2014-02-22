require 'spec_helper'

feature "leader" do

  scenario "signs up for an account with Facebook and is prompted to finish" do
    user = signup_user_with_facebook
    expect( page.body ).to have_content "Thanks for signing up, #{user.name}!"
    expect( page.current_url ).to eq leader_finish_signup_url
  end

  scenario "signs up for an account with Twitter and is prompted to finish" do
    user = signup_user_with_twitter
    expect( page.body ).to have_content "Thanks for signing up, #{user.name}!"
    expect( page.current_url ).to eq leader_finish_signup_url
  end

  scenario "finishes their signup process by entering email" do
    signup_user_with_facebook
    expect( page.current_url ).to eq leader_finish_signup_url
    full_name = "Nathaniel Watts"
    nickname  = "nathaniel.watts"
    success_message = "You're officially signed up, #{full_name}!"

    fill_in "Full Name", :with => "Nathaniel Watts"
    fill_in "Email",     :with => "reg@nathanielwatts.com"
    click_on "Finish Signup"

    expect( page.body ).to have_content success_message
    expect( page.current_url ).to eq leader_dashboard_url(:nickname => nickname)
    expect(ActionMailer::Base.deliveries.last.to).to eq(
      ['reg@nathanielwatts.com'])
  end
end
