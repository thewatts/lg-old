class GroupLeader < ActiveRecord::Base
  belongs_to :user
  belongs_to :lifegroup
end
