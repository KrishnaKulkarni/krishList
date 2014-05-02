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
    
    ad_options = self.options.includes(:option_value) #.includes(:option_class)
    matching_alerts = []
    
    self.candidate_alerts.each do |alert|
      matching_alert = true
            
      unless(matches_date_or_integer_options?(alert.alert_integer_options, ad_options) &&
        matches_date_or_integer_options?(alert.alert_date_options, ad_options) && 
        matches_string_or_boolean_options?(alert.alert_string_options, ad_options) &&
        matches_string_or_boolean_options?(alert.alert_boolean_options, ad_options))
         
         matching_alert = false      
      end
      #debugger
      matching_alerts << alert if(matching_alert) 
    end
    
    matching_alerts.each do |alert|
      alert.notify_user(self)
    end    
  end
  
  private
  # unless(matches_integer_options?(alert, ad_options) 
#     && matches_date_options?(alert, ad_options))
#     matching_alert = false
#   end
#   
  # def matches_integer_options?(alert, ad_options)
  #   alert_integer_options = alert.alert_integer_options
  # 
  #   alert_integer_options.each do |alert_integer_option|
  #     ##need to know whether it's a greater than or less than filter
  #     matched_option = ad_options.select do |ad_option|
  #        ad_option.option_class_id == alert_integer_option.option_class_id
  #     end
  #           
  #     return false unless(matched_option.present?)
  #      
  #     if(alert_integer_option.is_lower_bound)
  #       return false unless(alert_integer_option.value <= matched_option.option_value.value)
  #     else
  #       return false unless(alert_integer_option.value >= matched_option.option_value.value)
  #     end
  #   end
  #   true
  # end
  # 
  # def matches_date_options?(alert, ad_options)
  #   alert_date_options = alert.alert_date_options
  #   
  #   alert_date_options.each do |alert_date_option|
  #     matched_option = ad_options.select do |ad_option|
  #       ad_option.option_class_id == alert_date_option.option_class_id
  #     end
  # 
  #     return false unless(matched_option.present?)
  #   
  #     if(alert_date_option.is_lower_bound)
  #       return false unless (alert_date_option.value <= matched_option.option_value.value)
  #     else
  #       return false unless (alert_date_option.value >= matched_option.option_value.value)
  #     end
  #   end
  #   true
  # end
  
  ###
  
  #matched_option = ad_options.detect do |ad_option| ad_option.option_class_id == alert_option.option_class_id end
  
  # integer_alert_options = alert.alert_integer_options
 #  date_alert_options = alert.alert_date_options
 #  matches_date_or_integer_options(alert_integer_options, ad_options) && matches_date_or_integer_options(alert_date_options, ad_options) 
  def matches_date_or_integer_options?(alert_options, ad_options)    
    alert_options.each do |alert_option|
      matched_option = ad_options.detect do |ad_option|
        ad_option.option_class_id == alert_option.option_class_id
      end
  
      return false unless(matched_option.present?)
    
      if(alert_option.is_lower_bound)
        return false unless (alert_option.value <= matched_option.option_value.value)
      else
        return false unless (alert_option.value >= matched_option.option_value.value)
      end
    end
    true
  end
  
  def matches_string_or_boolean_options?(alert_options, ad_options)
    alert_options.each do |alert_option|
      is_matched = ad_options.any? do |ad_option|
        (ad_option.option_class_id == alert_option.option_class_id &&
        alert_option.value == ad_option.option_value.value)
      end
      return false unless(is_matched)
    end
    true
  end
  
  #this implementation leverages the fact that as of yet, boolean options are only created for 'true' values
  # once I alter that feature, I will simply use the string_option_method
  # ---> NEVERMIND, I'll just set it up now so that it will work in either case
  # def matches_boolean_options?(alert_options, ad_options)
#     alert_options.each do |alert_option|
#       
#       
#     end
#     true
#   end
  
  ###
  
  
  def ensure_flag_count
    self.flag_count ||= 0
  end
end
