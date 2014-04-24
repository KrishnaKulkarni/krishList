class Notification < ActiveRecord::Base
  before_validation :assign_default_viewed
  validates :notifiable, :message_id, presence: true
  belongs_to :notifiable, polymorphic: true
  # add after create email to the relevant user

  private
  def assign_default_viewed
    self.viewed ||= false
    true
  end

end
