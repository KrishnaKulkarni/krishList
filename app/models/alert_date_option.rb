class AlertDateOption < ActiveRecord::Base
  belongs_to :alert
  belongs_to :option_class
  
  validates :alert, :option_class, :value, presence: true #Should change validation to validate that date is a valid date
  validates :is_lower_bound, inclusion: { in: [true, false] }
  
  scope :is_min, -> { where(is_lower_bound: true) }
  scope :is_max, -> { where(is_lower_bound: false) }
  scope :for_option, -> (option_class_id) { where(option_class_id: option_class_id) }
  
end
