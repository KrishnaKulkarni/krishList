class DateOptionValue < ActiveRecord::Base

  has_one :option, as: :option_value, inverse_of: :option_value
  validates :option, presence: true
end
