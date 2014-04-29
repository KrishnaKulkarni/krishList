class Category < ActiveRecord::Base
  validates :title, presence: true

  has_many :subcats, inverse_of: :category, dependent: :destroy
  
  has_many(:option_classes, 
    as: :option_classable,
    inverse_of: :option_classable,
    dependent: :destroy)

end
