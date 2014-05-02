class Alert < ActiveRecord::Base
  belongs_to :subcat, inverse_of: :alerts
  belongs_to :user, inverse_of: :alerts
  has_many :notifications, as: :notifiable, inverse_of: :notifiable,
   dependent: :destroy
  
  has_many :alert_integer_options, inverse_of: :alert, dependent: :destroy
  has_many :alert_string_options, inverse_of: :alert, dependent: :destroy 
  has_many :alert_boolean_options, inverse_of: :alert, dependent: :destroy
  has_many :alert_date_options, inverse_of: :alert, dependent: :destroy
  
  validates :subcat, :user, presence: true
  
  scope :for_user, -> (user_id) { where(user_id: user_id) }
  scope :for_subcat, -> (subcat_id) { where(subcat_id: subcat_id) }
  
  
  def alert_options
    self.alert_integer_options.load
    .concat(self.alert_string_options)
    .concat(self.alert_boolean_options)
    .concat(self.alert_date_options)
  end
  
  def notify_user(ad)
     #create notification for the user
     notification = self.notifications.unviewed.event(:new_relevant_ad).new
     notification.user = self.user
     notification.ad = ad
     notification.save!
  end

end
