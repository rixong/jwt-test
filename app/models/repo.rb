class Repo < ApplicationRecord
  has_many :timeline_repos
  has_many :timelines, through: :timeline_repos
end
