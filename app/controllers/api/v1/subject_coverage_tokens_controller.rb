class Api::V1::SubjectCoverageTokensController < ApplicationController
  def create
    @subject_coverage = SubjectCoverage.find_by_name(permitted_subject_coverage_params[:name])

    if @subject_coverage
      render json: {
        coverage_token: JsonWebToken.encode(subject_coverage_id: @subject_coverage.id),
        name: @subject_coverage.name,
        id: @subject_coverage.id
      }
    else
      head :unauthorized
    end
  end

  private

  def permitted_subject_coverage_params
    params.require(:subject_coverage).permit(:name)
  end
end
