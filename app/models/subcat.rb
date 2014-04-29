class Subcat < ActiveRecord::Base
  validates :title, :category, presence: true
  belongs_to :category, inverse_of: :subcats
  has_many :ads, inverse_of: :subcat, dependent: :destroy
  
  has_many(
    :option_classes, 
    as: :option_classable,
    inverse_of: :option_classable,
    dependent: :destroy)
  
  #has_many :inherited_option_classes, through: :category, source: :option_classes
  def combined_option_classes
    OptionClass.where("(option_classable_id = ? AND option_classable_type = ?) 
    OR (option_classable_id = ? AND option_classable_type = ?)",
     self.id, 'Subcat', self.category_id, 'Category')
  end
  
  def mandatory_option_classes
    combined_option_classes.mandatory
  end
  
end
