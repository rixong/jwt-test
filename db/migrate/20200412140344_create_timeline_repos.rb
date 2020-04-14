class CreateTimelineRepos < ActiveRecord::Migration[6.0]
  def change
    create_table :timeline_repos do |t| 
      t.integer :timeline_id
      t.integer :repo_id
    end
  end
end

