class LeadersController < ApplicationController
  def index
    send_to_dashboard(current_user) if current_user
  end
end
