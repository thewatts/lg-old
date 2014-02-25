require 'spec_helper'

feature "lifegroups" do

  let(:user) { create(:user, :nickname => "thewatts") }

  before do
    create(:semester, :name => "Fall 2014")
    @npruzaniec = create(:user, :display_name => "Nathan Pruzaniec")
    @jparker    = create(:user, :display_name => "J Parker")
    current_user_is(user)
  end

  scenario "can be created with basic info" do
    visit leader_dashboard_path(:nickname => user.nickname)
    click_on "Create Group"
    expect(page.current_url).to eq new_leader_lifegroup_url(
      :nickname => user.nickname)

    name = "New Breed"
    fill_in "Name",            :with => name
    select "Fall 2014",        :from => "Semester"
    fill_in "Description",     :with => "A small group of men."
    # https://gist.github.com/thijsc/1391107 -- for later
    select "Nathan Pruzaniec", :from => "Co Leaders"
    select "J Parker",         :from => "Co Leaders"
    click_on "Save and Continue"
    group = Lifegroup.last

    expect(page).to have_content "#{name}'s basic information saved."
    expect(page.current_url).to eq leader_group_steps_edit_specifics_url(
      :nickname => user.nickname,
      :group_number => group.number
    )

    expect(group.leaders).to include user, @npruzaniec, @jparker
  end

  scenario "creation can be continued with specific info"
  scenario "creation can be continued with contact info"
  scenario "can be reviewd before submission"
  scenario "can be submitted for approval"
end
