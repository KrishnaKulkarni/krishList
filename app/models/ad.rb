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

  has_many :options, inverse_of: :ad, dependent: :destroy
  has_many :option_values, through: :options, source: :option_value

  validates(:title, :start_date, :region, :price, :subcat,
  :submitter, presence: true)


  has_attached_file :pic1, styles: {
    full: "600x450#",
    big: "450x450>",
    thumbnail: "50x50#"
  }

  validates_attachment_content_type :pic1, :content_type => /\Aimage\/.*\Z/

  def option_classes
    OptionClass.where("(option_classable_id = ? AND option_classable_type = ?) 
    OR (option_classable_id = ? AND option_classable_type = ?)",
     self.subcat_id, 'Subcat', self.subcat.category_id, 'Category')
  end
  
  def mandatory_option_classes
    option_classes.mandatory
  end

  private
  def ensure_flag_count
    self.flag_count ||= 0
  end
end
