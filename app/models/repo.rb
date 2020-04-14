class Repo < ApplicationRecord
  has_many :timelines_repos
  has_many :timelines, through: :timelines_repos
end
