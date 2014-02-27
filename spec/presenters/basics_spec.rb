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
    group = build(:lifegroup, :semester_id => nil)
    basics = Basics.new(group)
    expect(basics).to be_invalid
    expect(basics.errors[:semester_id]).not_to be_nil
  end

  it "needs a privacy status" do
    group = build(:lifegroup, :privacy => nil)
    basics = Basics.new(group)
    expect(basics).to be_invalid
    expect(basics.errors[:privacy]).not_to be_nil
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
    semester = create(:semester)
    expect(basics).to be_invalid
    basics.update(:name => "valid", :description => "valid description",
                  :semester_id => semester.id, :privacy => "closed")
    expect(basics).to be_valid
    expect(group.completed_steps).to include :basics
    expect(group.semester).to eq semester
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
