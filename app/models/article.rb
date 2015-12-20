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
#  daleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#

class Article < ActiveRecord::Base
  belongs_to :user
end
