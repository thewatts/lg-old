module Overlord
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
        flash[:success] = "Successfully added semester #{@semester.name}."
        redirect_to overlord_semesters_path
      else
        flash[:error] = "Oops, something went wrong."
        render :new
      end
    end

    private
    def semester_params
      params.require(:semester).permit(:name, :start_date, :end_date)
    end
  end
end
