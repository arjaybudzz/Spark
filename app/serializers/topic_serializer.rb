class TopicSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :discussion
end
