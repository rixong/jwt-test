require 'open-uri'
require 'net/http'
require 'json'

class TimelinesController < ApplicationController

  def create
    
  end

  def index
    timelines = Timeline.where("user_id = ?", current_user.id)
    render json: timelines
  end

end