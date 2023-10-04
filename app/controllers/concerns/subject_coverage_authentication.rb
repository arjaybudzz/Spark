module SubjectCoverageAuthentication
  def current_subject_coverage
    return @current_subject_coverage if @current_subject_coverage

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_subject_coverage = SubjectCoverage.find(decoded[:subject_coverage_id]) rescue ActiveRecord::RecordNotFound
  end
end
