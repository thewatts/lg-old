require 'spec_helper'

describe Semester do
  describe "lifegroups" do
    it "should have many lifegroups" do
      group = create(:lifegroup)
      semester = build(:semester)
      semester.lifegroups << group
      expect(semester.lifegroups).to include group
    end
  end
end
