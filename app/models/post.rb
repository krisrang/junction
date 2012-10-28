class Post
  include Mongoid::Document

  # belongs_to :user
  # has_many :reply_tokens
  # delegate :username, :colour, to: :user, prefix: true

  field :_id,           type: String
  field :slug,          type: String
  field :type,          type: String
  field :format,        type: String
  field :tags,          type: Array
  field :highlighted,   type: Array
  field :title,         type: String
  field :body,          type: String
  field :caption,       type: String
  field :date,          type: DateTime
  field :updated_at,     type: DateTime

  # Photo
  field :source_url,    type: String
  field :source_title,  type: String
  field :link_url,      type: String
  field :photos,        type: Array

  # Video
  field :permalink_url,     type: String
  field :thumbnail_url,     type: String
  field :thumbnail_width,   type: Integer
  field :thumbnail_height,  type: Integer
  field :html5_capable,     type: Boolean
  field :player,            type: String

  index({ tags: 1 })

  def images
    self.photos.map { |p| Hashie::Mash.new(p) }
  end

  def self.sync
    begin
      posts = Tumblr.new.posts

      return unless posts

      Post.delete_all

      posts.each do |post|
        next unless post.state.to_s == "published"

        record = Post.new(post)
        record.id = post.id.to_s
        record.updated_at = post.date
        record.save
      end

      return true
    rescue
      Rails.logger.info "Tumblr API down again"
    end
  end
end
