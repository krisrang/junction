class PostController < ApplicationController
  def index
    @posts = Tumblr.new.posts

    fresh_when freshness_options(@posts.max_by(&:date).date)
  end

  def show
    @post = Tumblr.new.post(params[:id]).first

    fresh_when freshness_options(@post.date)
  end

  def tag
    @posts = Tumblr.new.tag(params[:tag])

    render :index if stale? (@posts.max_by(&:date).date)
  end

  def projects
    set_expires
  end
end
