class ContentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :message
  belongs_to :owner
  belongs_to :recipient
end
