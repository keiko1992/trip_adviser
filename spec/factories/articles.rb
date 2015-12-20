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

FactoryGirl.define do
  factory :article do
    user_id {Faker::Number.number(1)}
    title {Faker::Lorem.sentence}
    content {Faker::Lorem.paragraph}
    place {Faker::Address.city}
    slug {Faker::Number.hexadecimal(12)}

    factory :published_article do
      published true
      published_at Time.zone.now
    end

    factory :future_article do
      published true
      published_at Time.zone.now + 1.week
    end

    factory :hidden_article do
      published false
      published_at Time.zone.now
    end

    factory :featured_article do
      published true
      published_at Time.zone.now
      featured true
      featured_at Time.zone.now
    end
  end

end
