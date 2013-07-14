class Event < ActiveRecord::Base
  has_many :cohorts_events
  has_many :cohorts, through: :cohorts_events

  scope :by_day, ->(today) { where(start_time: today.beginning_of_day..today.end_of_day) } 

  def self.by_week(today)
    sunday = today.beginning_of_week(start_day = :sunday)
    saturday = today.end_of_week(end_day = :saturday)
    self.where(start_time: sunday..saturday)
  end

  def to_s
    "#{self.start_time.strftime("%a, %b %d %I:%M%p")} ~ #{self.end_time.strftime("%I:%M%p")}, #{self.name} - #{self.cohorts.map(&:name)}"
  end
end
