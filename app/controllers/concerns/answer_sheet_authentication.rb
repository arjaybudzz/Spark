module AnswerSheetAuthentication
  def current_answer_sheet
    return @current_answer_sheet if @current_answer_sheet

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_answer_sheet = AnswerSheet.find(decoded[:answer_sheet_id]) rescue ActiveRecord::RecordNotFound
  end
end
