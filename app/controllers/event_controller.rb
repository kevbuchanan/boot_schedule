class EventController

  TODAY = Event.all.first.start_time
  
  def events_for(period, cohort = nil)
    events = find_for_period(period).to_a
    events.select! { |event| event.cohorts.map(&:name).include?(cohort) } if cohort
    events
  end

  def find_for_period(period)
    case period.downcase
    when 'today'
      Event.by_day(TODAY)
    when 'week'
      Event.by_week(TODAY)
    when 'phase'
      'not done yet'
    end
  end
end