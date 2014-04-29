class Ad < ActiveRecord::Base
  attr_reader :entered_options
  
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
  
  has_many :integer_option_values, through: :options, source: :option_value, source_type: 'IntegerOptionValue' 
  has_many :string_option_values, through: :options, source: :option_value, source_type: 'StringOptionValue'   
  has_many :boolean_option_values, through: :options, source: :option_value, source_type: 'BooleanOptionValue' 
  has_many :date_option_values, through: :options, source: :option_value, source_type: 'DateOptionValue' 

  validates(:title, :start_date, :region, :price, :subcat,
  :submitter, presence: true)


  has_attached_file :pic1, styles: {
    full: "600x450#",
    big: "450x450>",
    thumbnail: "50x50#"
  }

  validates_attachment_content_type :pic1, :content_type => /\Aimage\/.*\Z/

  #Note: The following is not an AREL; it cannot be since it concatenates entries multiple different tables.
  def option_values
    self.integer_option_values.all
    .concat(string_option_values)
    .concat(boolean_option_values)
    .concat(date_option_values)
  end

  def entered_options=(entered_options)
    #return unless entered_options.class == 'Hash'.constantize
    
    entered_options.each do |(opt_class_id, raw_value)|
      next unless raw_value #how else can I ensure/validate that no option is created without raw data
      option = self.options.new()
      option.option_class = OptionClass.find(opt_class_id)
      option.raw_value = raw_value
    end 
  end
   
  # a1 = Subcat.first.ads.new(
#     title: 'For Rent! 1st Avenue and East 10th St- 3 bedroom Apartment',
#     start_date: "May 01 2014",
#     region: "mnh",
#     price: 4600,
#      description: 'Super cozy! 5 Min from the Subway!', entered_options: { "3" => "cottage", "1" => "3"} )

  def option_classes
    self.subcat.combined_option_classes
  end
  
  private
  
  def ensure_flag_count
    self.flag_count ||= 0
  end
end
