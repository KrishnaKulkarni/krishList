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
  
  def alert_options
    self.integer_options.all
    .concat(string_options)
    .concat(boolean_options)
    .concat(date_options)
  end
  
  def notify_user
     #create notification for the user
  end

end
