class PostController < ApplicationController
  def index
    @posts = Tumblr.new.posts

    fresh_when last_modified: @posts.max_by(&:date).date, public: true
  end

  def show
    @post = Tumblr.new.post(params[:id]).first

    fresh_when last_modified: @post.date, public: true
  end

  def tag
    @posts = Tumblr.new.tag(params[:tag])

    render :index if stale? last_modified: @posts.max_by(&:date).date, public: true
  end

  def projects
    set_expires
  end
end
