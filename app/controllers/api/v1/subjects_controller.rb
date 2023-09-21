class Api::V1::SubjectsController < ApplicationController
  before_action :setup_subject, only: %i[show update destroy]
  before_action :check_login, only: %i[create]
  before_action :check_owner, only: %i[update destroy]

  def index
    @subject = Subject.all
    render json: SubjectSerializer.new(@subject).serializable_hash
  end

  def show
    render json: SubjectSerializer.new(@subject).serializable_hash
  end

  def create
    @subject = current_admin.subjects.build(permitted_subject_params)

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

  def check_owner
    head :forbidden unless @subject.admin_id == current_admin&.id
  end
end
