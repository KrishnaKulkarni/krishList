class Option < ActiveRecord::Base

  belongs_to :ad
  belongs_to :option_class
  belongs_to :option_value, polymorphic: true, inverse_of: :option, dependent: :destroy

  validates :ad, :option_class, presence: true
  
  def raw_value=(raw_value)
    puts "raw_value="
    self.option_value = self.option_class.value_type.constantize.new(value: raw_value)
  end
end
