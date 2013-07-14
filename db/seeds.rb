require 'csv'

def csv_loader(csv_file)
  hashes = []
  CSV.foreach(csv_file, :headers => true, :converters => [:date_time], :header_converters => :symbol) do |row|
    hashes << row.to_hash
  end
  hashes
end

file = File.expand_path('../cohorts.csv', __FILE__)
csv_loader(file).each do |cohort|
  Cohort.create(cohort)
end

file = File.expand_path('../boots.csv', __FILE__)
csv_loader(file).each do |boot|
  boot[:cohort_id] = Cohort.find_by_name(boot[:cohort]).id
  boot.delete(:cohort)
  Boot.create(boot)
end

file = File.expand_path('../events.csv', __FILE__)
csv_loader(file).each do |event|
  event[:cohorts] = event[:cohorts].split(',')
  event[:cohorts].each do |cohort_name|
    cohort = Cohort.find_by_name(cohort_name)
    cohort.add_event(event[:name], Time.parse(event[:start_time]), Time.parse(event[:end_time]))
  end
end


