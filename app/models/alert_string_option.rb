class AlertStringOption < ActiveRecord::Base
  belongs_to :alert
  belongs_to :option_class
  
  validates :alert, :option_class, :value, presence: true #Should change validation to validate that date is a valid string
  scope :for_option, -> (option_class_id) { where(option_class_id: option_class_id) }
  
end
