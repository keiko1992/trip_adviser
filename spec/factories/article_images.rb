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

FactoryGirl.define do
  factory :article_image do
    article_id {Faker::Number.number(1)}
  end

end
