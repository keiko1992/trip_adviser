# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  title        :string
#  content      :text
#  place        :string
#  slug         :string
#  published    :boolean          default(FALSE)
#  published_at :datetime
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
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
    path: Settings.s3.public.article_image_path
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def authenticated_image_url(style)
    image.s3_object(style).url_for(:read, secure: true)
  end

  def self.publishable
    Article.where(published: true).where(['published_at < ?', Time.zone.now])
  end

  def self.latest_articles(number)
    Article.publishable.order(published_at: :desc, id: :desc).limit(number)
  end

  def self.featured_articles(number)
    Article.publishable.where(featured: true).order(published_at: :desc, id: :desc).limit(number)
  end

  def self.popular_article_ids(number)
    Redis.zrevrange "articles/all", 0, number - 1
  end

  def previous_article
    Article.publishable.where(['published_at < ?', self.published_at]).order(published_at: :desc).first
  end

  def next_article
    Article.publishable.where(['published_at > ?', self.published_at]).order(published_at: :asc).first
  end
end
