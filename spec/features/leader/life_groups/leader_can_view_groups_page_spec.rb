require 'spec_helper'

feature "User" do

  let(:user) { create(:user) }

  before do
    page.set_rack_session(:user_id => user.id)
  end

  scenario "can view their groups page without groups" do
    visit leader_dashboard_path(:nickname => user.nickname)
    expect(page).to have_content "You don't have any groups yet."
    expect(page).to have_link("Create Group")
  end
end
