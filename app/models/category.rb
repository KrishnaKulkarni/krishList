class Category < ActiveRecord::Base
  validates :title, presence: true

  has_many :subcats, inverse_of: :category, dependent: :destroy
  has_many :options, as: :optionable, inverse_of: :optionable, dependent: :destroy

end
