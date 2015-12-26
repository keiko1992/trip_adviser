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
  it "has a valid factory" do
    expect(build(:article_image)).to be_valid
  end

  it "belongs to article" do
    is_expected.to belong_to(:article)
  end

  it "is invalid without an article_id" do
    article_image = build(:article_image, article_id: nil)
    article_image.valid?
    expect(article_image).to be_invalid
  end
end
