class Subcat < ActiveRecord::Base
  validates :title, :category, presence: true
  belongs_to :category, inverse_of: :subcats
  has_many :ads, inverse_of: :subcat, dependent: :destroy
  has_many :options, as: :optionable, inverse_of: :optionable, dependent: :destroy
end
