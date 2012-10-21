class PostController < ApplicationController
  respond_to :json, :html

  def index
    @posts = Tumblr.query.posts
    respond_with @posts
  end

  def projects
  end

  def show
  end

  def tag
  end
end
