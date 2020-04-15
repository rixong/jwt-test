require 'open-uri'
require 'net/http'
require 'json'

class ReposController < ApplicationController

  def create
    user_name = params[:github_username].downcase
    url = "https://api.github.com/users/#{user_name}/repos"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    result = JSON.parse(response.body)
    if response.message != 'OK' || result.count == 0 
      render json: {message: "Not a valid Github Username"}
    else
      if !Repo.find_by(git_username: user_name)
        tl = Timeline.create(name: user_name, user_id: current_user.id)
        result.each do |repo|
          rp = Repo.create(
            git_id: repo['id'], 
            name: repo['name'], 
            git_username: user_name,
            html_url: repo['html_url'],
            branches_url: repo['branches_url'],
            repo_created_at: repo['created_at'],
            repo_updated_at: repo['updated_at']
          )
          TimelineRepo.create(timeline_id: tl.id,repo_id: rp.id)
        end
      end
      repos = Repo.where("git_username = ?", user_name)
      render json: {message: "OK!", result: repos}
    end
  end

  def index

    

  end

end