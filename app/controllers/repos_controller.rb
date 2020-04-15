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
      ### Checks if request is valid URI and there is content
    if response.message != 'OK' || result.count == 0 
      render json: {message: "Not a valid Github Username"}
    else
        ### Checks if Timeline already exists for current user, if not it creates one
      tl = Timeline.where(['name = ? and user_id = ?',user_name, current_user.id])
      if tl.empty?
        puts 'New timeline  !XXXXXXXXXXXXXXXXXXXXXXXXXXX'
        tl = Timeline.create(name: user_name, user_id: current_user.id)
      end
      # pry
        ## Creates a new repo if doesn't exist
      result.each do |repo|
          ### if repo doesn't exist, create it
        if !Repo.find_by(git_id: repo['id'])
          rp = Repo.create(
            git_id: repo['id'], 
            name: repo['name'],
            git_username: user_name,
            html_url: repo['html_url'],
            branches_url: repo['branches_url'],
            repo_created_at: repo['created_at'],
            repo_updated_at: repo['updated_at']
          )
        end
          ##Create unique TLR for each repo (for curUser)
          puts "XXXXXXXX #{tl[0].id} .. #{repo['id']}"
        TimelineRepo.create(timeline_id: tl[0].id, repo_id: repo['id'])
      end
      repos = Repo.where("git_username = ?", user_name)
      render json: {message: "OK!", result: repos}
      # render json: {message: "OK!"}
    end
  end

end