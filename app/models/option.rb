class Option < ActiveRecord::Base
  #attr_accessor :raw_value
  belongs_to :ad
  belongs_to :option_class
  belongs_to :option_value, polymorphic: true, inverse_of: :option, dependent: :destroy

  validates :ad, :option_class, presence: true
  # after_create :create_option_value
  
  def raw_value=(raw_value)
    puts "raw_value called"
    p raw_value
    self.option_value = self.option_class.value_type.constantize.new(value: raw_value)
    puts "option value"
    p self.option_value
  end
  
  
  # def create_option_value
  #   return if self.option_value
  #   
  #   option_value = self.option_class.value_type.new(value: self.raw_value)
  #   option_value.save!
  #   
  #   self.option_value = option_value
  #   #self.save!?
  # end

end
