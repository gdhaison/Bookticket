admin = Admin.create!(name: "BinhPham",
                      email: "binh@gmail.com",
                      password: "123456",
                      password_confirmation: "123456"
                     )

user = User.create!(name: "Winfrey",
             email: "win@gmail.com",
             full_name: "Oprah Winfrey",
             phone_number: "0964980884",
             address: "America",
             password: "123456",
             password_confirmation: "123456"
            )

25.times do |n|
name  = Faker::Name.unique.name
email = Faker::Internet.unique.email
password = 123456
User.create!(name: name,
            email: email,
            full_name: "Oprah Winfrey",
            phone_number: "0964980884",
            address: "America",
            password: password,
            password_confirmation: password,
            created_at: Faker::Date.between(1.weeks.ago, Date.today)
            )
end

city1 = City.create!(name: "HaNoi")
city2 = City.create!(name: "DaNang")
city3 = City.create!(name: "HCM")
city4 = City.create!(name: "Osaka")
city5 = City.create!(name: "Fukuoka")

i = 0
5.times do |n|
  i = i+1
  theater = Theater.create!(name: "Ruby cinema #{City.find(i).name}", city_id: i)
end

arrCategories = ["Romance", "Action", "Cartoon", "Documentary", "Music"]
arrCategories.each do |cat|
  Category.create(name: cat)
end

def create_30_seats room_id
  for row in ("A".."E") do
    for col in (1..6) do
      seat = Seat.new
      seat.name = "#{row}#{col}"
      seat.room_id = room_id
      seat.available = true
      seat.save
    end
  end
end

i = 0
5.times do |n|
  i = i+1
  room = Room.create!(name: "Spring #{City.find(i).name}", theater_id: i)
  create_30_seats room.id
  room2 = Room.create!(name: "Summer #{City.find(i).name}", theater_id: i)
  create_30_seats room2.id
end


10.times do |n|
  name = Faker::Book.unique.title
  category = Category.all.sample
  Movie.create!(name: name,
                available: true,
                category: category,
                description: Faker::Lorem.paragraph,
                director: Faker::Name.unique.name,
                actor: Faker::Name.unique.name,
                rated: "16+",
                release: Faker::Date.between(1.years.ago, Date.today),
                trailer: "https://www.youtube.com/watch?v=HZ7PAyCDwEg",
                created_at: Faker::Date.between(7.weeks.ago, Date.today))
end

def create_showtime_seats room_id, movie_theater_id
  room = Room.find room_id
  room.seats.each do |seat|
    showtime_seat = ShowtimeSeat.new
    showtime_seat.movie_theater_id = movie_theater_id
    showtime_seat.seat_id = seat.id
    showtime_seat.seat_available = seat.available
    showtime_seat.save
  end
end

movies = Movie.all
2.times do |n|
  movies.each do |movie|
    theater = Theater.all.sample
    movie_theater = movie.movie_theaters.create!( theater_id: theater.id,
      room_id: theater.rooms.sample.id, time: Faker::Time.between(7.days.ago, Date.today))
    create_showtime_seats movie_theater.room_id, movie_theater.id
  end
end

20.times do |n|
  user = User.all.sample
  total = Faker::Number.number(5)
  Order.create!( user: user,
                 total: total,
                  )
end

movie = MovieTheater.all.sample
orders = Order.take(50)
2.times do |n|
  orders.each { |order| order.order_items.create!(movie_theater: movie, seat: Seat.first, created_at: Faker::Date.between(2.weeks.ago, Date.today)) }

end

