# schema
# t.string   "title",           null: false
# t.string   "input_type",      null: false
# t.string   "datatype",        null: false
# t.integer  "optionable_id",   null: false
# t.string   "optionable_type", null: false
# t.boolean  "is_mandatory",    null: false
# t.datetime "created_at"
# t.datetime "updated_at"

class Option < ActiveRecord::Base
  belongs_to :optionable, polymorphic: true, inverse_of: :options
  
  validates :title, :optionable, :is_mandatory, presence: true
  validates :input_type, inclusion: [in: %w<checkbox date datetime email number range text>]
  validates :datatype, inclusion: [in: %w<boolean date datetime float decimal integer string text>]
end
