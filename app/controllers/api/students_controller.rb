module Api
  class StudentsController < BaseController
    before_action :set_course, only: :create

    def create
      @course.add_student!(user_params)
      render json: { status: :created }
    end

    private

    def user_params
      params.require(:student).permit(:first_name, :last_name, :email, :uid)
    end

    def set_course
      @course = Course.find_by(slug: "#{params[:organization]}/#{params[:repository]}")
    end

  end

end