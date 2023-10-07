class Api::V1::SubjectsController < ApplicationController
  before_action :setup_subject, only: %i[show update destroy]
  before_action :check_existing_coverage, only: %i[create]
  before_action :check_coverage, only: %i[update destroy]

  def index
    @subject = Subject.all
    render json: SubjectSerializer.new(@subject).serializable_hash
  end

  def show
    options = { include: %i[subject_coverage topics] }
    render json: SubjectSerializer.new(@subject, options).serializable_hash
  end

  def create
    @subject = current_subject_coverage.subjects.build(permitted_subject_params)

    if @subject.save
      render json: SubjectSerializer.new(@subject).serializable_hash, status: :created
    else
      render json: @subject.errors, status: :unprocessable_entity
    end
  end

  def update
    if @subject.update(permitted_subject_params)
      render json: SubjectSerializer.new(@subject).serializable_hash, status: :ok
    else
      render json: @subject.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @subject.destroy
    head 204
  end

  private

  def setup_subject
    @subject = Subject.find(params[:id])
  end

  def permitted_subject_params
    params.require(:subject).permit(:name)
  end

  def check_coverage
    head :forbidden unless @subject.subject_coverage_id == current_subject_coverage&.id
  end
end
