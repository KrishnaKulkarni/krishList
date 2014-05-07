class BooleanOption < ActiveRecord::Base
  
  belongs_to :ad, inverse_of: :boolean_options
  belongs_to :option_class, inverse_of: :boolean_options
  
  validates :ad, :option_class, presence: true
  validates :value, inclusion: { in: [true, false] }
  
  
end
