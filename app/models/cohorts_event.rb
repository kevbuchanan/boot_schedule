class CohortsEvent < ActiveRecord::Base
  belongs_to :cohort
  belongs_to :event
end
