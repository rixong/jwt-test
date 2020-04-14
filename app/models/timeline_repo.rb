class TimelineRepo < ApplicationRecord
  belongs_to :timeline
  belongs_to :repo
end