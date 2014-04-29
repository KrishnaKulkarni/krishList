class Ad < ActiveRecord::Base
  before_validation :ensure_flag_count

  belongs_to :subcat, inverse_of: :ads
  belongs_to(
  :submitter,
  class_name: 'User',
  foreign_key: :submitter_id, inverse_of: :posted_ads
  )
  has_many :responses, inverse_of: :ad, dependent: :destroy

  has_many :response_notifications, through: :responses, source: :notification

  has_one :category, through: :subcat, source: :category
  has_many :subcat_options, through: :subcat, source: :options
  has_many :category_options, through: :category, source: :options

  validates(:title, :start_date, :region, :price, :subcat,
  :submitter, presence: true)


  has_attached_file :pic1, styles: {
    full: "600x450#",
    big: "450x450>",
    thumbnail: "50x50#"
  }
  
 validates_attachment_content_type :pic1, :content_type => /\Aimage\/.*\Z/

 def options
   # Option.join(:subcat_options).join(:category_options)
   
   Option.where("(optionable_id = ? AND optionable_class = ?) OR
   (optionable_id = ? AND optionable_class = ?)",
    self.subcat_id, 'Subcat', self.category.id, 'Category')
 end

  private
  def ensure_flag_count
    self.flag_count ||= 0
  end
end
