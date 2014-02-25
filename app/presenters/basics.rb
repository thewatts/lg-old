require 'forwardable'

class Basics
  include ActiveModel::Validations
  extend Forwardable

  validates :name,        :presence => true
  validates :description, :presence => true
  validates :semester_id, :presence => true

  def_delegators :group, :name, :description, :semester_id

  attr_reader :group

  def initialize(group)
    @group = group
  end

  def update(attributes)
    group.update(attributes)
    if valid?
      group.complete! :basics
      true
    else
      false
    end
  end
end
