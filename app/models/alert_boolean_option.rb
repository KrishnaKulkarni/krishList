class AlertBooleanOption < ActiveRecord::Base
  belongs_to :alert
  belongs_to :option_class
  
  validates :value, inclusion: { in: [true, false] } 
  validates :alert, :option_class, presence: true
end
