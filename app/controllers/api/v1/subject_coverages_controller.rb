class Api::V1::SubjectCoveragesController < ApplicationController
  before_action :setup_subject_coverage, only: %i[show]
  before_action :check_login, only: %i[create]

  def index
    @subject_coverage = SubjectCoverage.all
    render json: SubjectCoverageSerializer.new(@subject_coverage).serializable_hash
  end

  def show
    options = { include: %i[admin subjects] }
    render json: SubjectCoverageSerializer.new(@subject_coverage, options).serializable_hash
  end

  def create
    @subject_coverage = current_admin.subject_coverages.build(permitted_subject_coverage_params)

    if @subject_coverage.save
      render json: SubjectCoverageSerializer.new(@subject_coverage).serializable_hash, status: :created
    else
      render json: @subject_coverage.errors, status: :unprocessable_entity
    end
  end

  private

  def setup_subject_coverage
    @subject_coverage = SubjectCoverage.find(params[:id])
  end

  def permitted_subject_coverage_params
    params.require(:subject_coverage).permit(:name)
  end
end
