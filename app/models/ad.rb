class Ad < ActiveRecord::Base
  before_validation :ensure_flag_count
  validates(:title, :start_date, :end_date, :region, :price, :subcat,
  :submitter, :flag_count, presence: true)

  belongs_to :subcat, inverse_of: :ads
  belongs_to(
  :submitter,
  class_name: 'User',
  foreign_key: :submitter_id, inverse_of: :posted_ads
  )
  has_many :responses, inverse_of: :ad, dependent: :destroy

  private
  def ensure_flag_count
    self.flag_count ||= 0
  end
end
