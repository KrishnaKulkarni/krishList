class Response < ActiveRecord::Base
  belongs_to :ad, inverse_of: :responses
  belongs_to(
  :author,
  class_name: 'User',
  foreign_key: :respondent_id,
  inverse_of: :authored_responses
  )

  #add polymorphic associations later
  validates :ad, :author, :title, :body, :respondable_id,
   :respondable_type, presence: true

end
