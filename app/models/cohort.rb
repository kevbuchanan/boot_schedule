class Cohort < ActiveRecord::Base
  has_many :boots
  has_many :cohorts_events
  has_many :events, through: :cohorts_events

  def add_event(name, start_time, end_time)
    event = Event.find_or_create_by(name: name, start_time: start_time, end_time: end_time)
    CohortsEvent.create(cohort_id: self.id, event_id: event.id)
  end
end
