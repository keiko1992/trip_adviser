require 'csv'

csv = CSV.read('db/fixtures/development/csv/article.csv')

csv.each_with_index do |article, i|
  # skip a label row
  next if i === 0

  id = article[0].to_i
  user_id = article[1].to_i
  title = article[2].to_s
  slug = article[3].to_s
  content = article[4].to_s
  published = article[5]
  place = article[6].to_s

  Article.seed do |s|
    s.id = id
    s.user_id = user_id
    s.title = title
    s.slug = slug
    s.content = content
    s.place = place
    s.published = published
    s.published_at = Time.zone.now
  end
end
