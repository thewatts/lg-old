require 'spec_helper'

feature "leader" do

  scenario "signs up for an account with Facebook and is prompted to finish" do
    name = "Joe Bloggs"
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => 'facebook',
      :uid      => '12345',
      :info     => {
        :nickname   => 'jbloggs',
        # :email      => 'joe@bloggs.com',
        :name       => name,
        :first_name => 'Joe',
        :last_name  => 'Bloggs',
        :image      => 'http://graph.facebook.com/1234567/picture?type=square'
      }
    })
    visit leader_signup_path
    click_on "Signup with Facebook"
    expect( page.body ).to have_content "Thanks for signing up, #{name}!"
    expect( page.current_url ).to eq leader_finish_signup_url(
      :nickname => "jbloggs")
  end

  scenario "finishes their signup process by entering email" do
    signup_user_with_facebook
    user     = User.last
    nickname = user.nickname
    name     = user.name
    expect( page.current_url ).to eq leader_finish_signup_url(
      :nickname => user.nickname)

    fill_in "Email", :with => "joe@bloggs.com"
    click_on "Finish Signup"
    expect( page.body ).to have_content "You're officially signed up, #{name}!"
    expect( page.current_url ).to eq leader_dashboard_url(:nickname => nickname)
  end

  def signup_user_with_facebook
    name = "Joe Bloggs"
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => 'facebook',
      :uid      => '12345',
      :info     => {
        :nickname   => 'jbloggs',
        # :email      => 'joe@bloggs.com',
        :name       => name,
        :first_name => 'Joe',
        :last_name  => 'Bloggs',
        :image      => 'http://graph.facebook.com/1234567/picture?type=square'
      }
    })
    visit leader_signup_path
    click_on "Signup with Facebook"
  end
end
