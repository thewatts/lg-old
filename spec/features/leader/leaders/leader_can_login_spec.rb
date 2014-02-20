require 'spec_helper'

feature "leader" do

  scenario "logs in with Facebook" do
    OmniAuth.config.add_mock(:facebook, {
      :uid => '12345',
      :info => {
        :nickname => 'thewatts',
        :name => "Nathaniel Watts"
      }
    })
    user = create(:user, :nickname => "thewatts")
    visit leader_signup_path
    click_link "Signup with Facebook"
    expect( page.body ).to have_content "Congrats, #{user.name},"
    expect( page.current_url ).to eq leader_dashboard_url(
      :nickname => user.nickname)
  end
end
