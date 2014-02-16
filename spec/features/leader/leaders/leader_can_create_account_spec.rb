require 'spec_helper'

feature "leader" do
  scenario "signs up for an account with Facebook" do
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => 'facebook',
      :uid => '12345',
      :info => {
        :nickname => 'jbloggs',
        :email => 'joe@bloggs.com',
        :name => 'Joe Bloggs',
        :first_name => 'Joe',
        :last_name => 'Bloggs',
        :image => 'http://graph.facebook.com/1234567/picture?type=square',
        :urls => { :Facebook => 'http://www.facebook.com/jbloggs' },
        :location => 'Palo Alto, California',
        :verified => true
      }
    })
    visit leader_signup_path
    click_on "Signup with Facebook"
    expect( page.body ).to have_content "You're successfully logged in!"
    expect( page.current_url ).to eq leader_dashboard_url(:nickname => "jbloggs")
  end
end
