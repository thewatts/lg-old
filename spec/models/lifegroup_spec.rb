require 'spec_helper'

describe Lifegroup do

  it "generates a group number" do
    group = build(:lifegroup, :number => nil)
    group.save
    expect(group.number).to eq "0000#{group.id}"
  end

  it "has leaders" do
    leader = create(:user)
    group  = build(:lifegroup)
    group.leaders << leader
    expect(group.leaders).to include leader
  end

  it "leaders include the creator" do
    leader = create(:user)
    group = leader.lifegroups.create!(
      :name        => "My cool group",
      :description => "This is my group",
      :semester    => build(:semester)
    )
    expect(group.leaders).to include leader
  end

  describe "validations" do
    it "must have a group_number" do
      group = build(:lifegroup, :number => nil)
      group.save
      expect(group.number).not_to be_nil
    end

    it "must have a name" do
      group = build(:lifegroup, :name => nil)
      expect(group).to be_invalid
    end

    it "must have a description" do
      group = build(:lifegroup, :description => nil)
      expect(group).to be_invalid
    end

    it "must have a semester" do
      group = build(:lifegroup, :semester => nil)
      expect(group).to be_invalid
    end
  end

  describe "group steps" do
    it "exist" do
      group = build(:lifegroup)
      steps = [:basics, :specifics, :location, :submission, :approved]
      expect(group.steps).to eq steps
    end

    it "have not been completed on creation" do
      group = build(:lifegroup)
      expect(group.completed_steps).to eq []
    end

    it "can be completed" do
      group = build(:lifegroup)
      group.complete!(:basics)
      expect(group.completed_steps).to include :basics
    end

    it "can only be completed if valid" do
      group = build(:lifegroup)
      group.complete!(:invalid_step)
      expect(group.completed_steps).not_to include :invalid_step
    end

    it "can't be completed more than once" do
      group = build(:lifegroup)
      group.complete!(:basics)
      expect(group.completed_steps).to eq [:basics]
      group.complete!(:basics)
      expect(group.completed_steps).to eq [:basics]
    end

    it "can be found by current step" do
      group = build(:lifegroup)
      group.complete!(group.steps[0])
      expect(group.next_step).to eq group.steps[1]
    end
  end

  describe "associations" do
    it "has a semester" do
      semester = create(:semester)
      group = build(:lifegroup, :semester => semester)
      expect(group.semester).to eq semester
    end
  end
end
