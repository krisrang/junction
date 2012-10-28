class PostController < ApplicationController
  def index
    @posts = Post.all.desc(:date)
  end

  def show
    @post = Post.find(params[:id])

    fresh_when last_modified: @post.updated_at.utc, etag: @post
  end

  def tag
    @posts = Post.where(tags: params[:tag]).all
    render :index
  end

  def projects
  end
end
