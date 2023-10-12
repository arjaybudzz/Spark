class PostUpVoteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :is_clicked

  belongs_to :post
end
