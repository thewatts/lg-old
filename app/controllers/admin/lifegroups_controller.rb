module Admin
  class LifegroupsController < ApplicationController

    def index
    end

    def new
      @lifegroup = Lifegroup.new
    end

  end
end
