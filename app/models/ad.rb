class Ad < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_content, against: [:title, :description]
  
  attr_reader :entered_options
  
  before_validation :ensure_flag_count

  belongs_to :subcat, inverse_of: :ads
  has_many :candidate_alerts, through: :subcat, source: :alerts 
  
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

  has_many :pictures, inverse_of: :ad, dependent: :destroy

  has_attached_file :pic1, styles: {
    full: "600x450#",
    big: "450x450>",
    thumbnail: "50x50#"
  }

  validates_attachment_content_type :pic1, :content_type => /\Aimage\/.*\Z/

  after_commit :execute_alerts, on: [:create]

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
  

  def execute_alerts
    #iterate through all alerts, filtering out ones that don't match; with each of the remaining alerts, call Alert#notify_user
    
    ad_options = self.options#.includes(:option_class)
    matching_alerts = []
    self.candidate_alerts.each do |alert|
      matching_alert = true
      
      # Checking each alert option, determining whether they all match; otherwise filter out this alert
      ##Filtering integer alert options
      unless(matches_integer_options?(alert, ad_options))
        matching_alert = false
        break
      end
      ####
      [ 
        :alert_integer_options,
        :alert_boolean_options,
        :alert_string_options,
        :alert_date_options 
      ].each do |options_set|
        alert_options = alert.try(options_set)
        alert_options.present? && alert_options.each do |alert_option| #the .present? check shouldn't be necessary
          match = 
        
        end 
      ####
         
      end
      
      
    end
  end
  private
  def matches_integer_options?(alert, ad_options)
    alert_integer_options = alert.alert_integer_options

    alert_integer_options.each do |alert_integer_option|
      ##need to know whether it's a greater than or less than filter
      matched_option = ad_options.select do |ad_option|
         ad_option.option_class_id == alert_integer_option.option_class_id
      end
      
      return false unless(matched_option.present?)
       
      if(alert_integer_option.is_lower_bound)
        return false unless(alert_integer_option.value <= matched_option.option_value.value)
      else
        return false unless(alert_integer_option.value >= matched_option.option_value.value)
      end
    end
    true
  end
  
  
  def ensure_flag_count
    self.flag_count ||= 0
  end
end
