require 'spec_helper'

describe Leadership do
  it "needs leadership" do
    group = build(:lifegroup, :leader_ids => nil)
    leadership = Leadership.new(group)
    expect(leadership).to be_invalid
    expect(leadership.errors[:leader_ids]).not_to be_nil
  end

  it "updates the group's leaders" do
    user  = create(:user)
    user2 = create(:user)
    group = user.lifegroups.create(:name => "My Cool Group")
    expect(group.leaders).to eq [user]
    leadership = Leadership.new(group)
    leadership.update(:leader_ids => [user.id, user2.id])
    expect(group.leaders).to eq [user, user2]
    expect(group.completed_steps).to include :leadership
  end

  it "won't update if there are no leaders" do
    group = build(:lifegroup, :leader_ids => nil)
    leadership = Leadership.new(group)
    expect(leadership.update(:leader_ids => [])).to be_false
    expect(group.completed_steps).not_to include :leadership
  end
end
