class CommentDownVoteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :is_clicked

  belongs_to :comment
end
