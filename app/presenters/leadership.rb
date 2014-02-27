require 'forwardable'

class Leadership
  include ActiveModel::Conversion
  include ActiveModel::Validations
  extend Forwardable

  validates :leader_ids, :presence => true

  def_delegators :group, :leader_ids

  attr_reader :group

  def initialize(group)
    @group = group
  end

  def update(attributes)
    group.update(attributes)
    if valid?
      group.complete! :leadership
      true
    else
      false
    end
  end
end
