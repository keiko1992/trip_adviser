require 'csv'

csv = CSV.read('db/fixtures/development/csv/admin.csv')

csv.each_with_index do |admin, i|
  # skip a label row
  next if i === 0

  id = admin[0].to_i
  email = admin[1].to_s
  password = admin[2].to_s

  Admin.seed do |s|
    s.id = id
    s.email = email
    s.password = password
  end
end
