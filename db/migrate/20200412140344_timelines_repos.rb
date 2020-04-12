class TimelinesRepos < ActiveRecord::Migration[6.0]
  def change
    create_table :timelines_repos do |t| 
      t.integer :timeline_id
      t.integer :repo_id
    end
  end
end
