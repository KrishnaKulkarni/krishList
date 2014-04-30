class Picture < ActiveRecord::Base
  belongs_to :ad
  
  validates :ad, presence: true
  
  has_attached_file :image, styles: {
    full: "600x450#",
    big: "450x450>",
    thumbnail: "50x50#"
  }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
