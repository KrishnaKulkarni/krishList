class DateOption < ActiveRecord::Base
  belongs_to :ad, inverse_of: :date_options
  belongs_to :option_class, inverse_of: :date_options
  
  validates :ad, :option_class, :value, presence: true
end
