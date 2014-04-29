class Option < ActiveRecord::Base
  attr_accessor :raw_value
  belongs_to :ad
  belongs_to :option_class
  belongs_to :option_value, polymorphic: true, inverse_of: :option, dependent: :destroy

  validates :ad, :option_class, :option_value_id, presence: true
  after_validation :create_option_value_type
  
  private
  def create_option_value_type
    return if self.option_value_type
  
    option_value = self.option_class.value_type.new(value: self.raw_value)
    option_value.option = self
    option_value.save!
  end

end
