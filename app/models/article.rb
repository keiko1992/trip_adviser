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
end
