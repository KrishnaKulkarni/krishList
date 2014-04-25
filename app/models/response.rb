class Response < ActiveRecord::Base
  belongs_to :ad, inverse_of: :responses, counter_cache: true
  has_one :recipient, through: :ad, source: :submitter

  belongs_to(
  :author,
  class_name: 'User',
  foreign_key: :respondent_id,
  inverse_of: :authored_responses
  )

  has_many :notifications, as: :notifiable, inverse_of: :notifiable,
   dependent: :destroy

  after_commit :create_notifications, on: [:create]

  validates :ad, :author, :title, :body, presence: true

  private
  def create_notifications
    #ad scoping later
    notification = self.notifications.unviewed.event(:new_response).new
    notification.user = self.recipient
    #change to unsafe saving later
    notification.save!
  end

end
