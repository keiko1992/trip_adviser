# == Schema Information
#
# Table name: articles
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  title              :string
#  content            :text
#  place              :string
#  slug               :string
#  published          :boolean          default(FALSE)
#  published_at       :datetime
#  deleted_at         :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  image_processing   :boolean
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Article, type: :model do
  it "has a valid factory" do
    expect(build(:article)).to be_valid
  end

  it "belongs to user" do
    is_expected.to belong_to(:user)
  end

  it "has many article_images" do
    is_expected.to have_many(:article_images)
  end

  it "is invalid without an user_id" do
    article = build(:article, user_id: nil)
    article.valid?
    expect(article).to be_invalid
  end

  it "is invalid without a title" do
    article = build(:article, title: nil)
    article.valid?
    expect(article).to be_invalid
  end

  it "is invalid with a non-unique title" do
    existingarticle = create(:article, title: "Awesome Title")
    article = build(:article, title: "Awesome Title")
    article.valid?
    expect(article).to be_invalid
  end

  it "is invalid without a place" do
    article = build(:article, place: nil)
    article.valid?
    expect(article).to be_invalid
  end

  it "is invalid without a slug" do
    article = build(:article, slug: nil)
    article.valid?
    expect(article).to be_invalid
  end

  it "is invalid with a non-unique slug" do
    existingarticle = create(:article, slug: "Awesome-Title")
    article = build(:article, slug: "Awesome-Title")
    article.valid?
    expect(article).to be_invalid
  end

  it "is invalid without a content" do
    article = build(:article, content: nil)
    article.valid?
    expect(article).to be_invalid
  end

  it "deletes a its record softly" do
    article = create(:article)
    article.destroy
    expect(article.paranoia_destroyed?).to eq(true)
  end

  it "remains soft-deleted record" do
    article1 = create(:article)
    article1.destroy
    article2 = create(:article)
    expect(Article.count).to eq 1
    expect(Article.with_deleted.count).to eq 2
  end
end
