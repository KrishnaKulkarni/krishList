class Category < ActiveRecord::Base
  validates :title, presence: true

  has_many :subcats, inverse_of: :category, dependent: :destroy

end
