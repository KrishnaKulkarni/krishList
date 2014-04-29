#schema
# t.string   "title",                                 null: false
# t.integer  "option_classable_id",                   null: false
# t.string   "option_classable_type",                 null: false
# t.string   "input_type",                            null: false
# t.string   "value_type",                            null: false
# t.boolean  "is_mandatory",          default: false
# t.datetime "created_at"
# t.datetime "updated_at"


class OptionClass < ActiveRecord::Base

  VALUE_TYPE = {
    "number"  => "IntegerOptionValue",
    "checkbox"  => "BooleanOptionValue",
    "text"  => "StringOptionValue",
    "date"  => "DateOptionValue"
  }
  INPUT_TYPES = VALUE_TYPE.keys
  
  belongs_to :option_classable, polymorphic: true, inverse_of: :option_classes
  
  has_many :options, inverse_of: :option_class, dependent: :destroy
  
  validates :input_type, inclusion: { in: INPUT_TYPES }
  validates :is_mandatory, inclusion: { in: [true, false] }
  validates :option_classable, :title, presence: true
  
  after_validation :assign_value_type
  
  scope :mandatory, -> { where(is_mandatory: true) }
  scope :discretionary, -> { where(is_mandatory: false) }
  
  private
  def assign_value_type
    self.value_type = VALUE_TYPE[self.input_type]
  end
  
end
