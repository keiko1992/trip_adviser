# == Schema Information
#
# Table name: articles
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  title              :string
#  content            :text
#  place              :string
#  slug               :string
#  published          :boolean          default(FALSE)
#  published_at       :datetime
#  deleted_at         :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  image_processing   :boolean
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#

class Article < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :title, :slug, :content, :place, presence: true
  validates :title, :slug, uniqueness: true

  acts_as_paranoid

  extend FriendlyId
  friendly_id :slug, use: [:slugged, :history]

  has_attached_file :image,
    styles: {large: '1600x900#', small: '400x225#', ogp: '1200x630#', wide: '1600x500#', thumb: '300x300#'},
    path: Settings.s3.common.article_image_path
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  process_in_background :image, url_with_processing: false

  # Article status
  def self.publishable
    Article.where(published: true).where(['published_at < ?', Time.zone.now])
  end

  # pickup articles
  def self.latest_articles(number)
    Article.publishable.order(published_at: :desc, id: :desc).limit(number)
  end

  def self.featured_articles(number)
    Article.publishable.where(featured: true).order(published_at: :desc, id: :desc).limit(number)
  end

  def previous_article
    Article.publishable.where(['published_at < ?', self.published_at]).order(published_at: :desc).first
  end

  def next_article
    Article.publishable.where(['published_at > ?', self.published_at]).order(published_at: :asc).first
  end

  # PV ranking
  if ENV["REDISCLOUD_URL"]
    Redis = Redis.new(url: ENV["REDISCLOUD_URL"])
  else
    Redis = Redis.new
  end

  def store_pv
    unless Rails.env.test?
      Redis.zincrby("articles/daily/#{Date.today.to_s}", 1, "#{self.id}").to_i
      Redis.zincrby("articles/all", 1, "#{self.id}").to_i
    end
  end

  def self.popular_article_ids(number)
    Redis.zrevrange "articles/all", 0, number - 1
  end
end
