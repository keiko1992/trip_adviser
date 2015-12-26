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

class ArticleImage < ActiveRecord::Base
  belongs_to :article

  validates :article_id, presence: true

  has_attached_file :image,
    styles: {large: '1500x1000#', thumb: '300x200#'},
    s3_permissions: "public-read",
    path: Settings.s3.common.article_embedded_image_path
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
