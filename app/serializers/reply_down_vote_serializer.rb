class ReplyDownVoteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :is_clicked

  belongs_to :reply
end
