require 'spec_helper'

feature "org leader" do
  scenario "can create a semester" do
    visit admin_dashboard_path
    click_on "Manage Semesters"
    expect(page).to have_content "You currently have no semesters."
    click_on "Add Semester"
    name = "Fall 2014"
    fill_in "Name",       :with => name
    fill_in "Start date", :with => Time.current
    fill_in "End date",   :with => 3.months.from_now
    click_on "Create Semester"

    expect(page).to have_content "Successfully added semester #{name}."
  end
end
