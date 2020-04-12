class CreateRepos < ActiveRecord::Migration[6.0]
  def change
    create_table :repos do |t|
      t.string :git_id
      t.string :name
      t.string :html_url
      t.string :branches_url
      t.string :repo_created_at
      t.string :repo_updated_at
      t.timestamps
    end
  end
end
