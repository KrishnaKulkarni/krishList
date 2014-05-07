class StringOption < ActiveRecord::Base
  belongs_to :ad, inverse_of: :string_options
  belongs_to :option_class, inverse_of: :string_options
  
  validates :ad, :option_class, :value, presence: true
end
