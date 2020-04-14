class Timeline < ApplicationRecord
  belongs_to :user
  has_many :timeline_repos
  has_many :repos, through: :timeline_repos
end
