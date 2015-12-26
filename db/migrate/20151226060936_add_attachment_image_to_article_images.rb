class AddAttachmentImageToArticleImages < ActiveRecord::Migration
  def self.up
    change_table :article_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :article_images, :image
  end
end
