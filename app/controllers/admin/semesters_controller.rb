module Admin
  class SemestersController < ApplicationController
    def index
      @semesters = Semester.all
    end

    def new
      @semester = Semester.new
    end

    def create
      @semester = Semester.new(semester_params)
      if @semester.save
        send_to_dashboard
      else
        flash[:error] = "Oops, something went wrong."
        render :new
      end
    end

    private
    def semester_params
      params.require(:semester).permit(:name, :start_date, :end_date)
    end

    def send_to_dashboard
      flash[:success] = "Successfully added semester #{@semester.name}."
      redirect_to admin_semesters_path
    end
  end
end
