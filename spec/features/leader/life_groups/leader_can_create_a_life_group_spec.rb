require 'spec_helper'

feature "lifegroups" do

  let(:user) { create(:user, :nickname => "thewatts") }

  before do
    @semester   = create(:semester, :name => "Fall 2014")
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
    fill_in "Name",        :with => name
    fill_in "Description", :with => "A small group of men."
    select "Fall 2014",    :from => "Semester"
    select "Closed",       :from => "Privacy"
    click_on "Save and Continue"
    group = Lifegroup.last

    expect(page).to have_content "#{name}'s basic information saved."
    expect(page.current_url).to eq leader_group_steps_edit_leadership_url(
      :nickname => user.nickname,
      :group_number => group.number
    )

    expect(group.semester).to eq @semester
    expect(group.privacy).to eq "closed"
    expect(group.completed_steps).to include :basics
  end

  scenario "creation can be continued with leadership info" do
    group = user.lifegroups.create(:name => "My Cool Group")
    visit leader_group_steps_edit_leadership_url(
      :nickname => user.nickname,
      :group_number => group.number
    )

    expect(page).to have_content user.display_name
    select "Nathan Pruzaniec", :from => "Co Leaders"
    select "J Parker",         :from => "Co Leaders"
    click_on "Save and Continue"
    group = Lifegroup.last

    expect(group.completed_steps).to include :leadership
    expect(group.leaders).to include user, @npruzaniec, @jparker

    expect(page).to have_content "#{group.name}'s leadership information saved."
    expect(page.current_url).to eq(
      leader_group_steps_edit_meeting_details_url(
        :nickname => user.nickname,
        :group_number => group.number
      )
    )
  end

  scenario "creation can be continued with meeting details"
  scenario "can be reviewd before submission"
  scenario "can be submitted for approval"
end
