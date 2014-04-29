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
  

end
