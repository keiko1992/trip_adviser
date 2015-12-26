class AddImageprocessingToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :image_processing, :boolean
  end
end
