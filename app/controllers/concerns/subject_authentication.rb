module SubjectAuthentication
  def current_subject
    return @current_subject if @current_subject

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_subject = Subject.find(decoded[:subject_id]) rescue ActiveRecord::RecordNotFound
  end

  protected

  def check_existing_subject
    head :forbidden unless current_subject
  end
end
