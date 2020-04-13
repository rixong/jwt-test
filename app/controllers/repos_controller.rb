require 'open-uri'
require 'net/http'
require 'json'

class ReposController < ApplicationController

  def create
    
    url = "https://api.github.com/users/#{params[:github_username]}/repos"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    result = JSON.parse(response.body)
    result.each do |repo| 
      Repo.create(
        git_id: repo['id'], 
        name: repo['name'], 
        git_username: repo['owner']['login'],
        html_url: repo['html_url'],
        branches_url: repo['branches_url'],
        repo_created_at: repo['created_at'],
        repo_updated_at: repo['updated_at']
      )
    end
      render json: {message: "#{result.count} public repos were found for user:#{params[:github_username]} "}
  end

  def index

    

  end

end