class AlertIntegerOption < ActiveRecord::Base

  belongs_to :alert
  belongs_to :option_class

  validates :alert, :option_class, :value, presence: true #Should change validation to validate that date is a valid number
  validates :is_lower_bound, inclusion: { in: [true, false] }
end
