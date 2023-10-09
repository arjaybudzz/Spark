class ComputeScore

  def self.check_answer(answer_sheet)
    total_score = 0
    answer_sheet.quiz_answers.each do |quiz_answer|
      total_score += quiz_answer.quiz_item.point.to_i if quiz_answer.answer == quiz_answer.quiz_item.answer
    end

    answer_sheet.update(score: total_score)
  end
end
