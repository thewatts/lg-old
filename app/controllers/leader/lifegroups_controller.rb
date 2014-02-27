module Leader
  class LifegroupsController < ApplicationController

    def index
      @groups = current_user.lifegroups
    end

    def new
      group = current_user.lifegroups.create
      @basics = Basics.new(group)
    end

  end
end
