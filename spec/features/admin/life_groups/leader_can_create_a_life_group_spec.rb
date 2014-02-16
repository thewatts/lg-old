require 'spec_helper'

feature "lifegroups" do

  let(:user) { create(:user, :nickname => "thewatts") }

  before do
    create(:semester, :name => "Fall 2014")
  end

  scenario "can be created through the admin page" do
    visit leader_dashboard_path(:nickname => user.nickname)

    click_on "Create Group"
    name = "New Breed"
    fill_in "Name",            :with => name
    select "Fall 2014",        :from => "Semester"
    fill_in "Description",     :with => "A small group of men."
    # https://gist.github.com/thijsc/1391107 -- for later
    #select "Nathan Pruzaniec", :from => "Co Leaders"
    #select "J Parker",         :from => "Co Leaders"
    click_on "Create Life Group"

    expect(page).to have_content "Thanks for submitting #{name} for approval!"
  end
end
