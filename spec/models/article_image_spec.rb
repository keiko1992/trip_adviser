# == Schema Information
#
# Table name: article_images
#
#  id                 :integer          not null, primary key
#  article_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#
# Indexes
#
#  index_article_images_on_article_id  (article_id)
#

require 'rails_helper'

RSpec.describe ArticleImage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
