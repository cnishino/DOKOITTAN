# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Admin.create!(
#   email: "1@1",
#   password:111111
# )

Genre.create!([
    { name: '公園' },
    { name: '神社・お寺' },
    { name: '川・池'},
    { name: '海'},
    { name: '山'},
    { name: '児童館'},
    { name: '遊園地・テーマパーク'},
    { name: '動物園・植物園・博物館'},
    { name: 'お買い物'},
    { name: '飲食店'},
    { name: 'その他'},
    ])

  TargetAge.create!([
    { target: '乳児' },
    { target: '幼児' },
    { target: '小学校低学年' },
    { target: '小学校高学年' },
    { target: '中学校以上' },
    ])

5.times do |n|
  User.create!(
    email: "test#{n + 1}@test",
    name: "test#{n + 1}",
    password:"222222"
  )
end
