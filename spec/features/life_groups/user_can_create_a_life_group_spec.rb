require 'spec_helper'

feature "lifegroups" do
  scenario "can be created through the admin page" do
    visit admin_dashboard_path
    click_on "Create Group"
    title = "New Breed"
    fill_in "Name",        :with => title
    select "Fall 2014",    :from => "Semester"
    fill_in "Description", :with => "A small group of men."
    fill_in "Co-Leaders",  :with => "Nathan Pruzaniec"
    click_on "Create Life Group"

    expect(page).to have_content "Thanks for submitting #{title} for approval!"
  end
end
