require 'spec_helper'

feature "leader" do
  scenario "signs up for an account" do
    pending
    visit leader_signup_path
    fill_in "Login", :with => "thewatts"
    click_on "Signup"
  end
end
