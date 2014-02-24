require 'spec_helper'

describe Lifegroup do

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
