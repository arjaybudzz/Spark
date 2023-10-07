class Api::V1::SubjectTokensController < ApplicationController
  def create
    @subject = Subject.find_by_name(permitted_subject_params[:name])

    if @subject
      render json: {
        token: JsonWebToken.encode(subject_id: @subject.id),
        name: @subject.name,
        subject_coverage_id: @subject.subject_coverage_id,
        subject_id: @subject.id
      }
    else
      head :unauthorized
    end
  end

  private

  def permitted_subject_params
    params.require(:subject).permit(:name)
  end
end
