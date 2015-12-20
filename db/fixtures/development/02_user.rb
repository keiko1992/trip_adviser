require 'csv'

csv = CSV.read('db/fixtures/development/csv/user.csv')

csv.each_with_index do |user, i|
  # skip a label row
  next if i === 0

  id = user[0].to_i
  email = user[1].to_s
  password = user[2].to_s
  last_name = user[3].to_s
  first_name = user[4].to_s
  city = user[5].to_s

  User.seed do |s|
    s.id = id
    s.email = email
    s.password = password
    s.last_name = last_name
    s.first_name = first_name
    s.city = city
    s.confirmed_at = Time.zone.now
    s.slug = SecureRandom.hex(6)
  end
end
