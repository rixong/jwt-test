class Timeline < ApplicationRecord
  belongs_to :user
  has_many :timelines_repos
  has_many :repos, through: :timelines_repos
end
