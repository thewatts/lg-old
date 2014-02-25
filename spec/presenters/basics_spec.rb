require 'spec_helper'

describe Basics do

  it "needs a name" do
    group = build(:lifegroup, :name => nil)
    basics = Basics.new(group)
    expect(basics).to be_invalid
    expect(basics.errors[:name]).not_to be_nil
  end

  it "needs a description" do
    group = build(:lifegroup, :description => nil)
    basics = Basics.new(group)
    expect(basics).to be_invalid
    expect(basics.errors[:description]).not_to be_nil
  end

  it "needs a semester" do
    group = build(:lifegroup, :semester => nil)
    basics = Basics.new(group)
    expect(basics).to be_invalid
    expect(basics.errors[:semester]).not_to be_nil
  end

  it "updates attributes" do
    group = build(:lifegroup, :name => nil)
    basics = Basics.new(group)
    expect(basics).to be_invalid
    basics.update(:name => "valid")
    expect(basics).to be_valid
    expect(group.name).to eq basics.name
  end

  it "completes basics after adding valid data" do
    group = build(:lifegroup, :name => nil, :description => nil,
                  :semester => nil)
    basics = Basics.new(group)
    expect(basics).to be_invalid
    basics.update(:name => "valid", :description => "valid description",
                  :semester => build(:semester))
    expect(basics).to be_valid
    expect(group.completed_steps).to include :basics
  end

  it "remains invalid if not correctly updated" do
    group = build(:lifegroup, :name => nil, :description => nil,
                  :semester => nil)
    basics = Basics.new(group)
    expect(basics).to be_invalid
    attributes = { :name => nil, :description => nil, :semester => nil }
    expect(basics.update(attributes)).to be_false
    expect(group.completed_steps).not_to include :basics
  end

end
