class Subcat < ActiveRecord::Base
  validates :title, :category, presence: true
  belongs_to :category, inverse_of: :subcats
  has_many :ads, inverse_of: :subcat, dependent: :destroy
  
  has_many(
    :option_classes, 
    as: :option_classable,
    inverse_of: :option_classable,
    dependent: :destroy)
  
  belongs_to(
  :featured_option_class1,
  class_name: 'OptionClass',
  foreign_key: :featured_option_class_id1, inverse_of: :featured_first_subcats, dependent: :destroy)
  
  belongs_to(
  :featured_option_class2,
  class_name: 'OptionClass',
  foreign_key: :featured_option_class_id2, inverse_of: :featured_second_subcats, dependent: :destroy)
  
  has_many :inherited_option_classes, through: :category, source: :option_classes
  
  has_many :alerts, inverse_of: :subcat, dependent: :destroy
  
  scope :feature_text, -> (text) { where(featured_text: text) }
  
  
  def combined_option_classes
    OptionClass.where("(option_classable_id = ? AND option_classable_type = ?) 
    OR (option_classable_id = ? AND option_classable_type = ?)",
     self.id, 'Subcat', self.category_id, 'Category')
  end
  
  def mandatory_option_classes
    combined_option_classes.mandatory
  end
  
end
