require 'open-uri'
require 'net/http'
require 'json'

class ReposController < ApplicationController

  def create
    
    url = "https://api.github.com/users/#{params[:github_username]}/repos"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    result = JSON.parse(response.body)
    if response.message != 'OK' || result.count == 0 
      render json: {message: "Not a valid Github Username"}
    else
      if !Repo.find_by(git_username: params[:github_username])
        tl = Timeline.create(name: params[:github_username], user_id: current_user.id)
        result.each do |repo|
          rp = Repo.create(
            git_id: repo['id'], 
            name: repo['name'], 
            git_username: repo['owner']['login'],
            html_url: repo['html_url'],
            branches_url: repo['branches_url'],
            repo_created_at: repo['created_at'],
            repo_updated_at: repo['updated_at']
          )
          TimelineRepo.create(timeline_id: tl.id,repo_id: rp.id)
        end
      end
      repos = Repo.where("git_username = ?", params[:github_username])
      render json: {message: "OK!", result: repos}
    end
  end

  def index

    

  end

end