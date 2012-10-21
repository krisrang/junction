class PostController < ApplicationController
  after_filter :set_expires

  def index
    @posts = Tumblr.new.posts
  end

  def show
    @single = true
    @posts = Tumblr.new.post(params[:id])

    render action: :index
  end

  def tag
    @posts = Tumblr.new.tag(params[:tag])

    render action: :index
  end

  def projects
  end
end
