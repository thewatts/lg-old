require 'spec_helper'

feature "lifegroups" do

  let(:user) { create(:user, :nickname => "thewatts") }

  before do
    create(:semester, :name => "Fall 2014")
  end

  scenario "can be created with basic info" do
    visit leader_dashboard_path(:nickname => user.nickname)
    click_on "Create Group"
    expect(page.current_url).to eq leader_groups_edit_basic_info_url(
      :nickname => user.nickname)

    name = "New Breed"
    fill_in "Name",            :with => name
    select "Fall 2014",        :from => "Semester"
    fill_in "Description",     :with => "A small group of men."
    # https://gist.github.com/thijsc/1391107 -- for later
    # select "Nathan Pruzaniec", :from => "Co Leaders"
    # select "J Parker",         :from => "Co Leaders"
    click_on "Save and Continue"

    expect(page).to have_content "Specific Info for #{name}"
    expect(page.current_url).to eq group_creation_specific_info_url
  end
end
