require 'spec_helper'

describe Lifegroup do
  describe "associations" do
    it "has a semester" do
      semester = create(:semester)
      group = build(:lifegroup, :semester => semester)
      expect(group.semester).to eq semester
    end
  end
end
