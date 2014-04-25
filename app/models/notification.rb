class Notification < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  EVENTS = {
    1  => :new_response
  }

  EVENT_IDS = EVENTS.invert

  belongs_to :notifiable, polymorphic: true, inverse_of: :notifications
  belongs_to :user, inverse_of: :notifications, counter_cache: true
  # add after create email to the relevant user

  # before_validation :assign_default_viewed
  validates :notifiable, :user, presence: true
  validates :event_id, inclusion: { in: EVENTS.keys }
  validates :is_viewed, inclusion: { in: [true, false] }

  scope :viewed, -> { where(is_viewed: true) }
  scope :unviewed, -> { where(is_viewed: false) }
  scope :event, -> (event_name) { where(event_id: EVENT_IDS[event_name]) }

  def url
    case EVENTS[self.event_id]
      when :new_response
        response = self.notifiable
        #Implement later
    end
  end

  def text
    case EVENTS[self.event_id]
      when :new_response
        ad = self.notifiable.ad
        author = self.notifiable.author

        "Your ad '#{ad.title}' has a new response from #{author.username}"
    end
  end


  def default_url_options
    options = {}
    options[:host] = Rails.env.production? ? "krishlist.herokuapp" :
     "localhost:3000"
    options
  end

  private
  # def event_name
  #   EVENTS[]
  # end

  # def assign_default_viewed
#     self.is_viewed ||= false
#     true
#   end

end
