class AlertDateOption < ActiveRecord::Base
  belongs_to :alert
  belongs_to :option_class
  
  validates :alert, :option_class, :value, presence: true #Should change validation to validate that date is a valid date
end
