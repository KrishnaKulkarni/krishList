class Response < ActiveRecord::Base
  belongs_to :ad, inverse_of: :responses
  belongs_to(
  :author,
  class_name: 'User',
  foreign_key: :respondent_id,
  inverse_of: :authored_responses
  )

  #add polymorphic associations later
  validates :ad, :author, :title, :body, presence: true

  has_one :notification, as: :notifiable, dependent: :destroy

  after_create :create_notification

  private
  def create_notification
    self.create_notification!(message_id: 1)
  end

end
