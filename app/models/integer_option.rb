class IntegerOption < ActiveRecord::Base
  belongs_to :ad, inverse_of: :integer_options
  belongs_to :option_class, inverse_of: :integer_options
  
  validates :ad, :option_class, presence: true
  validates :value, numericality: { only_integer: true }
end
