class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :content
      t.string :place
      t.string :slug
      t.boolean :published, default: false
      t.datetime :published_at
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
